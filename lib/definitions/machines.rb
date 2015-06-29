def tgr
	@tgr ||= EngTagger.new
end

def stemmer
	@stemmer ||= Lingua::Stemmer.new(:language => "en")
end

def stemmed(word)
	stemmer.stem(word)
end
