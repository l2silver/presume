require 'spec_helper'

describe ResumeBuilder do
	
  doc = Docx::Document.open('sample_resume.docx').text
	
	resume_classifier = ResumeClassifier.new(doc, "Sample Person", "fake_presume_object")
	resume_classifier.classify

	let(:resume_builder){ResumeBuilder.new(resume_classifier.classifide_lines)}

    it 'should be properly setup' do
      expect(resume_classifier.classifide_lines.length).to be > 10
      expect(resume_builder.classifides.length).to be > 10
    end

  	it "it should complete first pass" do
  		resume_builder.first_pass
  		expect(resume_builder.classifides[0].type).to eq("section")
  	end

    it "it should complete second pass" do
      resume_builder.first_pass
      resume_builder.second_pass
      expect(resume_builder.classifides[0].type).to eq("section")
      resume_builder.classifides.values.each do |classifide|
        puts ("#{classifide.type} | #{classifide.text} | #{classifide.professions} | #{classifide.many_words?} ")
      end
    end

    it "it should build resume" do
      resume_builder.first_pass
      resume_builder.second_pass
      resume_builder.reset_header_x_start
      expect(resume_builder.instance_variable_get("@header_x_start")).to eq(true)
      resume_builder.instance_variable_get("@length").times do |n|
            resume_builder.set_classifide(n)
            @classifide = resume_builder.instance_variable_get("@classifide")
            expect(@classifide.id).to eq(n)
            unless @classifide.type?
                unless @classifide.type == "name" or @classifide.type == "email" or @classifide.type == "phone" or @classifide.type == "address"
                    resume_builder.send(@classifide.type + "_build")
                end
            end 
        end            
    end

    it "should build section" do
      resume_builder.first_pass
      resume_builder.second_pass
      resume_builder.instance_variable_get("@length").times do |n|
            resume_builder.set_classifide(n)
            @classifide = resume_builder.instance_variable_get("@classifide")
            
            unless @classifide.type?
                unless @classifide.type == "name" or @classifide.type == "email" or @classifide.type == "phone" or @classifide.type == "address"
                    if @classifide.type == "section"
                      resume_builder.send(@classifide.type + "_build")   
                      expect(resume_builder.instance_variable_get("@header_number")).to be_nil
                      expect(resume_builder.instance_variable_get("@section_number")).to eq(n)
                      expect(resume_builder.instance_variable_get("@header_x_start")).to be_truthy
                      expect(resume_builder.sections.values.length).to be > 0
                      expect(resume_builder.all_types.length).to be > 0
                    end
                end
            end 
        end            
      
    end

    it "should build header" do
      resume_builder.first_pass
      resume_builder.second_pass
      resume_builder.instance_variable_get("@length").times do |n|
            resume_builder.set_classifide(n)
            @classifide = resume_builder.instance_variable_get("@classifide")

            if resume_builder.all_types.values.nil?
              check_all_types_length = 0
            else  
              check_all_types_length = resume_builder.all_types.values.length
            end

            if (parent_types =resume_builder.all_types[resume_builder.section_number?]).nil?
              check_all_types_parent_length = 0
            else  
              check_all_types_parent_length = parent_types.length
            end

            if (headers = resume_builder.headers.values).nil?
              check_headers_length = 0
            else  
              check_headers_length = headers.length
            end

            
            unless @classifide.type?
                unless @classifide.type == "name" or @classifide.type == "email" or @classifide.type == "phone" or @classifide.type == "address"
                    if @classifide.type == "header"
                      resume_builder.send(@classifide.type + "_build")   
                      expect(resume_builder.instance_variable_get("@header_number")).to eq(n)
                      expect(resume_builder.instance_variable_get("@header_x_start")).to be_truthy
                      expect(resume_builder.bullets.values.length).to be > check_headers_length
                      expect(resume_builder.all_types.values.length).to be > check_all_types_length
                      expect(resume_builder.all_types[resume_builder.section_number?].length).to be > check_all_types_parent_length
                    end
                end
            end 
        end            
      
    end

    it "should build bullet" do
      resume_builder.first_pass
      resume_builder.second_pass
      resume_builder.instance_variable_get("@length").times do |n|
            resume_builder.set_classifide(n)
            @classifide = resume_builder.instance_variable_get("@classifide")

            if resume_builder.all_types.values.nil?
              check_all_types_length = 0
            else  
              check_all_types_length = resume_builder.all_types.values.length
            end

            if (parent_types =resume_builder.all_types[resume_builder.header_number?]).nil?
              check_all_types_parent_length = 0
            else  
              check_all_types_parent_length = parent_types.length
            end

            if (bullets = resume_builder.bullets.values).nil?
              check_bullets_length = 0
            else  
              check_bullets_length = bullets.length
            end

            unless @classifide.type?
                unless @classifide.type == "name" or @classifide.type == "email" or @classifide.type == "phone" or @classifide.type == "address"
                    if @classifide.type == "bullet"
                      resume_builder.send(@classifide.type + "_build")
                      expect(resume_builder.instance_variable_get("@header_x_start")).to be_truthy
                      expect(resume_builder.bullets.values.length).to be > check_bullets_length
                      expect(resume_builder.all_types.values.length).to be > check_all_types_length
                      expect(resume_builder.all_types[resume_builder.header_number?].length).to be > check_all_types_parent_length
                    end
                end
            end 
        end            
      
    end

    it "should build header_x" do
      resume_builder.first_pass
      resume_builder.second_pass
      resume_builder.instance_variable_get("@length").times do |n|
            resume_builder.set_classifide(n)
            @classifide = resume_builder.instance_variable_get("@classifide")
            
            if resume_builder.all_types.values.nil?
              check_all_types_length = 0
            else  
              check_all_types_length = resume_builder.all_types.values.length
            end

            if (parent_types =resume_builder.all_types[resume_builder.section_number?]).nil?
              check_all_types_parent_length = 0
            else  
              check_all_types_parent_length = parent_types.length
            end

            if (headers = resume_builder.headers.values).nil?
              check_headers_length = 0
            else  
              check_headers_length = headers.length
            end            
            
            unless @classifide.type?
                unless @classifide.type == "name" or @classifide.type == "email" or @classifide.type == "phone" or @classifide.type == "address"
                    if @classifide.type == "header_x"
                      resume_builder.send(@classifide.type + "_build")
                      
                      if resume_builder.classifide_after == "header_x"
                        if resume_builder.classifide_after == "header_x" and resume_builder.instance_variable_get("@header_x_start") == "almost"
                        else
                          expect(resume_builder.instance_variable_get("@header_x_start")).to be_falsy
                        end
                      
                        expect(resume_builder.bullets.values.length).to be > check_headers_length
                        expect(resume_builder.all_types.values.length).to be > check_all_types_length
                        expect(resume_builder.all_types[resume_builder.section_number?].length).to be > check_all_types_parent_length
                      end                      
                    end
                end
            end 
        end            
      
    end

    it "should add to all_types" do
      allow(resume_builder).to receive(:classifide) {"This is a fake classifide"}
      resume_builder.all_types
      expect(resume_builder.all_types.values.length).to eq(0)
      resume_builder.add_to_all_types(1)
      expect(resume_builder.all_types.values.length).to eq(1)
      resume_builder.add_to_all_types(1)
      expect(resume_builder.all_types.values.length).to eq(1)
      expect(resume_builder.all_types[1].length).to eq(2)
    end


  	
end