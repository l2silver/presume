require "engtagger"
require 'docx'
require 'lingua/stemmer'
require 'date'
require "definitions/regex.rb"
require "definitions/classifications.rb"
require "definitions/machines.rb"
require "sort/resume_builder.rb"
require "sort/resume_classifier.rb"
require "sort/classifide.rb"
require "sort/header.rb"
require "sort/bullet.rb"
require "sort/searchable.rb"
require "sort/searchables.rb"

class Presume

  attr_accessor :sections, :headers, :bullets, :all_types, :classifides
  
  def initialize(doc, name)
    @resume_classifier = ResumeClassifier.new(doc, name, self)
    @resume_classifier.classify
    @resume_builder = ResumeBuilder.new(@resume_classifier.classifide_lines)
    @resume_builder.first_pass
    @resume_builder.second_pass
    @resume_builder.build_resume
    @sections = @resume_builder.resume[:sections]
    @headers = @resume_builder.resume[:headers]
    @bullets = @resume_builder.resume[:bullets]
    @all_types = @resume_builder.resume[:all_types]
  end

  def get_sections_info
    @sections.values
  end

  def get_sections_id
    @sections.keys
  end

  def get_headers_info
    @headers.values
  end

  def get_headers_id
    @headers.keys
  end

  def get_bullets_info
    @bullets.values
  end

  def get_bullets_ids
    @bullets.keys
  end

  def get_id(id)
    @all_types[id][0]
  end

  def searchables?(hash) #word phrase => duration
    match_searchables_to_classifides(hash, @headers)
  end

  def skills?(hash) #word phrase => duration
    match_searchables_to_classifides(hash, @bullets)
  end

    def match_searchables_to_classifides(hash, classifides)
      setup_match_searchables(hash, classifides)
      check_for_searchable_match
      return @matched_searchables
    end

      def setup_match_searchables(hash, classifides)
        set_classifides(classifides)
        set_searchables(hash)
        reset_matched_searchables
      end

        def set_classifides(classifides)
          @classifides = classifides
        end

        def set_searchables(hash)
          @searchables = Searchables.new(hash)
        end

        def reset_matched_searchables
          @matched_searchables = []
        end

      def check_for_searchable_match
        classifide_objects.each do |classifide|
          searchable_objects.each do |searchable|
            if matched_text?(classifide, searchable) and matched_duration?(classifide, searchable)
              add_to_matched_searchables(classifide, searchable)
            end
          end
        end
      end

        def classifide_objects
          @classifides.values
        end

        def searchable_objects
          @searchables.all.values
        end

        def matched_text?(classifide, searchable)
          !classifide.text[searchable.regex].nil?
        end

        def matched_duration?(classifide, searchable)
          classifide.duration >= searchable.duration
        end

        def add_to_matched_searchables(classifide, searchable)
          @matched_searchables += [[searchable,classifide]]
        end
end

