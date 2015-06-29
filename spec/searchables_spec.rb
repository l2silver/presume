require 'spec_helper'

describe Searchables do

	let(:searchables_params){{"marketing coordinator" => 1}}
	let(:searchables) {Searchables.new({"marketing coordinator" => 1})}
	it "takes hash input" do
		new_searchable = Searchables.new(searchables_params)
		expect(new_searchable.raw.kind_of?(Hash)).to be_truthy
	end

	it "converts raw to all" do
		expect(searchables.instance_variable_get("@all").empty?).to be_truthy
		searchables.all
		expect(searchables.instance_variable_get("@all").empty?).to be_falsy
		first_key = searchables.all.keys[0]
		expect(searchables.all[first_key].class.name).to eq("Searchable")
	end



end
