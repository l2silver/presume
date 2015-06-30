class Searchable

	attr_accessor :raw_name, :duration
	
	def initialize(hash)
		@raw_name = hash[:raw_name]
		@duration = hash[:duration]
	end

	def separate_synonyms
		@separate_synonyms ||= @raw_name.split(Regexp.new("(| )\,(| )"))
	end

	def add_synonyms_to_names
		@names = {}
		separate_synonyms.each do |synonym|
			@names[synonym] = []
		end
	end

	def names
		if @names.nil?
			add_synonyms_to_names
			separate_synonyms.length.times do |n|
				@searchable_words = separate_synonyms[n].downcase.split
				@searchable_words.each do |word|
					@names[separate_synonyms[n]] += [stemmed(word)]
				end
			end
			@names
		else
			@names
		end
	end

	def regex
		if @regex.nil?
			@separate_regexes = []
			separate_synonyms.length.times do |n|
				@regexes = ""
				names[separate_synonyms[n]].each do |name|
					@regexes += '(?=.*' + name + ')'
				end
				@regexes += ".*"
				@separate_regexes += [@regexes]
			end
			
			@regex_count = 0
			
			@separate_regexes.each do |separate_regex|
				@regex_count += 1
				@new_regex = Regexp.new(separate_regex, "i")
			
				if @regex_count == 1
					@regex = @new_regex
				else
					@regex = Regexp.union(@regex, @new_regex)
				end
			end
		
			@regex
		else
			@regex
		end
	end

	def check_regex(searchable_title)
		!searchable_title.downcase[regex].nil?
	end

end