class ResumeClassifier

  attr_accessor :text, :lines, :classifide_lines

  def initialize(resume_text, name, presume)
  	@text = resume_text	
  	@classifide_lines = {}
  	@lines = []
    @user_name = name
    @presume = presume
    clean_text
  	split_text
  end

  def lines_together
    @lines_together ||= @lines.join("\n")
  end

  def tagged_lines_together
    @tagged_lines_together ||= tgr.add_tags(lines_together)
  end

  def tagged_lines
    @tagged_lines ||= tagged_lines_together.split("\n")
  end
  
  def regex_name
    Regexp.new(@user_name, "i")
  end

  def clean_text
    separate_tabbed_words
    remove_extra_spaces
  end

  def remove_extra_spaces
    @text = @text.gsub(regex_remove_extra_spaces, ",")
  end


  def separate_tabbed_words
    @text = @text.gsub(regex_separate_tabbed_words, ",")
  end

  def split_text
  	@lines = @text.split("\n")
  	remove_blanks
  end

  def remove_all_lines
    @lines = []
  end

  def remove_blanks
  	@lines = @lines.reject{|line| blank?(line)}
  end

  def number_of_lines
  	@lines.length
  end

  def blank?(line)
  	line[regex_characters_and_digits].nil?
  end

  def classify
  	number_of_lines.times do |n|
  		set_line_number(n)
  		set_line(n)
  		check_classifications
  		merge_to_classifide_lines
  	end
  end

  def line_text(n)
  	@lines[n]
  end

  def set_line(number)
  	@line = @lines[number]
  end

  def set_line_number(number)
  	@line_number = number
  end
 
  def check_classifications
  	classifications.each do |classification|
		set_classification_instance(classification)
  	end
  end

  def set_classification_instance(classification)
  	instance_variable_set(("@" + classification).to_sym, classification?(classification))
  end

  def classification?(classification)
  	@line[regex_(classification)]
  end

  def regex_(classification)
  	send("regex_#{classification}")
  end

  def merge_to_classifide_lines
  	pass_classification_instances_to_hash
  	@classifide_lines.merge!({@line_number => Classifide.new(@line_classifications.merge(line_non_regex_classifications))})  	
  end

  def line_non_regex_classifications
  	@non_regex_classications = {number_of_words: number_of_words, many_words: many_words, verbs: verbs?, text: @line, type: nil, id: @line_number, presume: @presume}
  end

  def remove_dates_and_cities
    @date_and_city_less_line = @line.gsub(Regexp.union(regex_dates,regex_dates_2,regex_cities),"")
  end
  def number_of_words
    @number_of_words = remove_dates_and_cities.split.size
  end

  def many_words
  	@number_of_words >= 5
  end

  def verbs?
  	if tagged_lines[@line_number].nil?
  		@verbs = nil
  	else
  		@verbs = tagged_lines[@line_number][regex_engtagger_verbs]
  	end
  end

  def pass_classification_instances_to_hash
  	@line_classifications = Hash[classifications.map{|classification| [classification.to_sym, instance_variable_get("@#{classification}")]}]
  end

end