require "spec_helper"

describe Classifide do

	classifide_params = {:phone => nil, :email => nil, :address => nil, :section => nil, :professions => "Project Coordinator ", :companies => "Thorns and Thistles Ltd.", :schools => nil, :dates => "September 2012 – January 2014", :dates_2 => nil, :number_of_words => 6, :many_words => true, :verbs => nil, :cities => "Toronto, Ontario", :text => "Project Coordinator, Thorns and Thistles Ltd., Toronto, Ontario, September 2012 – January 2014", :type => "header_x"}
	let(:classifide) {Classifide.new(classifide_params)}

	classifide_params_2 = {:phone => nil, :email => nil, :address => nil, :section => "of Toronto School of Continuing Education", :professions => nil, :companies => nil, :schools => "University of Toronto School of Continuing", :dates => "Summer 2013", :dates_2 => nil, :cities => nil, :number_of_words => 8, :many_words => true, :verbs => nil, :text => "University of Toronto School of Continuing EducationSummer 2013", :type => "header_x"}
	
	let(:classifide_2) {Classifide.new(classifide_params_2)}

	it "checks more words than" do
		expect(classifide.more_words_than?(5)).to be_truthy
		expect(classifide.more_words_than?(10)).to be_falsy
	end

end