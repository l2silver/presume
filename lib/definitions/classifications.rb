
  def classifications
    @classifications ||= ["name", "phone", "email", "address", "section", "professions", "companies", "schools", "dates", "cities"]
  end

  def non_regex_classifications
    non_regex_classifications ||= ["number_of_words", "many_words", "verbs", "text", "type", "id", "presume"]
  end

  def both_classifications
    @both_classifications ||= classifications + non_regex_classifications
  end

  def both_classifications_symboled
    both_classifications_symboled ||= both_classifications.map {|x| x.to_sym}
  end

  def header_classifications
    @header_classifications ||= ["professions", "companies", "schools", "dates", "cities"]
  end

  def set_time_at_inception(time, presume)
    instance_variable_set("@#{time}", presume)
  end