require 'spec_helper'

describe Presume do
	
	doc = Docx::Document.open('sample_resume.docx').text
    
	let(:presume){Presume.new(doc, "Sample Person")}

  searchable_params = {"Marketing Coordinator" => 1, "Project Coordinator" => 1}

  skill_params = {"present investment proposals" => 0, "clear communication" => 0}

  	it "should return sections" do
	    expect(presume.sections).to_not be_nil
  	end

  	it "should return section ids" do
	    expect(presume.get_sections_id.kind_of?(Array)).to be_truthy
  	end

  	it "should return section info" do
	    expect(presume.get_sections_info.kind_of?(Array)).to be_truthy
  	end

  	it "should return header ids" do
	    expect(presume.get_headers_id.kind_of?(Array)).to be_truthy
  	end

  	it "should return header info" do
	    expect(presume.get_headers_info.kind_of?(Array)).to be_truthy
  	end

  	it "should return children" do
	    expect(presume.sections[0].children.length).to be < presume.all_types[0].length
  	end

    it "should get matched searchables" do
      presume.instance_variable_set("@searchables", Searchables.new(searchable_params))
      presume.instance_variable_set("@matched_searchables", [])
      presume.headers.values.each do |header|
        presume.instance_variable_get("@searchables").all.values.each do |searchable|
          puts header.text
          puts header.dates
          puts searchable.duration
          puts header.duration

          if header.duration > searchable.duration
            puts "duration is greater"
            puts searchable.regex
            if !header.text[searchable.regex].nil?
              puts "match"
              presume.instance_variable_set("@matched_searchables", presume.instance_variable_get("@matched_searchables")) + [[searchable,header]]
            end
          end
        end
      end
      presume.instance_variable_get("@matched_searchables")
    end

  	it "should find similar searchable and time" do
    	expect(presume.searchables?(searchable_params).class.name).to eq("Array") 
      expect(presume.instance_variable_get("@matched_searchables").length).to eq(1)
      expect(presume.instance_variable_get("@matched_searchables")[0][0].raw_name).to eq("Project Coordinator")
    end

  	it "should find similar skills and times" do
      expect(presume.skills?(skill_params).class.name).to eq("Array")
      expect(presume.instance_variable_get("@matched_searchables").length).to eq(1)
      expect(presume.instance_variable_get("@matched_searchables")[0][1].text).to eq("Assisted in the financial reporting, pro forma analysis, and presentation of investment proposals to International stakeholders, leasing agents and project managers in Cantonese, Mandarin and English using Excel and Power,Point. ")
  	end

end