class Searchables

	attr_accessor :raw
	
	def initialize(hash)
		@raw = hash
		@all = {}
	end

	def duration(name)
		@raw[name]
	end

	def all
		if @all.empty?
			@raw.keys.each do |name|
				@all.merge!(name => Searchable.new({raw_name: name, duration: duration(name)}))
			end
			@all
		else
			@all
		end
	end
end