require 'spec_helper'

describe Searchable do

	searchable_params = {raw_name: "marketing coordinator", duration: 1}
	let(:searchables) {Searchables.new({"marketing coordinator" => 1})}
	let(:searchable){Searchable.new(searchable_params)}
	
	it "takes hash input" do
		searchables.all
		first_key = searchables.all.keys[0]
		expect(searchables.all[first_key].class.name).to eq("Searchable")
	end

	it "prepares names" do
		expect(searchable.instance_variable_get("@names").nil?).to be_truthy
		searchable.names
		expect(searchable.instance_variable_get("@names").nil?).to be_falsy
	end

	it "prepares regexes" do
		expect(searchable.instance_variable_get("@regex").nil?).to be_truthy
		searchable.regex
		expect(searchable.instance_variable_get("@regex").nil?).to be_falsy
	end

	it "checks regexes" do
		expect(searchable.check_regex("marketing coordinator")).to be_truthy
		expect(searchable.check_regex("marketing possey")).to be_falsy
	end



end
