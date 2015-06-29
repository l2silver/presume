class Searchable

	attr_accessor :raw_name, :duration
	
	def initialize(hash)
		@raw_name = hash[:raw_name]
		@duration = hash[:duration]
	end

	def names
		if @names.nil?
			@names = []
			@searchable_words = @raw_name.downcase.split
			@searchable_words.each do |word|
				@names += [stemmed(word)]
			end
			@names
		else
			@names
		end
	end

	def regex
		if @regex.nil?
			@regexes = ""
			names.each do |name|
				@regexes += '(?=.*' + name + ')'
			end
			@regexes += ".*"
			@regex = Regexp.new(@regexes, "i")
		else
			@regex
		end
	end

	def check_regex(searchable_title)
		!searchable_title.downcase[regex].nil?
	end

end