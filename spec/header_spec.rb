require "spec_helper"

describe Header do

	classifide_params = {:phone => nil, :email => nil, :address => nil, :section => nil, :professions => "Project Coordinator ", :companies => nil, :schools => nil, :dates => "September 2012 – January 2014", :cities => nil, :number_of_words => 7, :many_words => true, :verbs => nil, :text => "Project Coordinator, Thorns and Thistles Ltd., Toronto, Ontario, September 2012 – January 2014", :type => "header_x"}
	classifide = Classifide.new(classifide_params)	
	let(:header) {Header.new(classifide)}
	
	it "finds start time text" do
		expect(header.start_time_text?).to eq("September 2012")
	
	end

	it "finds start year" do
		expect(header.start_year).to eq("2012")
	
	end

	it "finds start time number" do
		expect(header.start_time_number).to eq(2012 + (8/12).to_f)
	end
	

	it "finds end time text" do
		expect(header.end_time_text?).to eq("January 2014")
	end

	it "finds end year" do
		expect(header.end_year).to eq("2014")
	end

	it "finds end time number" do
		expect(header.end_time_number).to eq(2014 + (0/12).to_f)
	end

	it "finds end time number" do
		header.instance_variable_set("@dates", 'September 2014 to present')
		puts header.dates
		expect(header.start_time_text?).to eq("September 2014")
		expect(header.end_time_number).to eq(2015 + (6/12).to_f)
	end

	it "checks if end time text is current job" do
		expect(header.current?).to be_falsy
	end

	it "removes date from text" do
		header.remove_date
		expect(header.clean_profession).to eq("Project Coordinator, Thorns and Thistles Ltd., Toronto, Ontario, ")
	end

	it "removes city from text" do
		header.remove_date
		header.remove_city
		expect(header.clean_profession).to eq("Project Coordinator, Thorns and Thistles Ltd., , ")
	end

	it "removes companies" do
		header.remove_date
		header.remove_city
		header.remove_institution
		expect(header.clean_profession).to eq("Project Coordinator, , , ")
	end

	it "removes companies" do
		header.remove_date
		header.remove_city
		header.remove_institution
		header.remove_all_but_profession
		expect(header.clean_profession).to eq("Project Coordinator")
	end

end