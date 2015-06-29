class Header < Classifide

	attr_accessor :clean_profession

	def initialize(classifide)
		both_classifications.each do |classification|
			instance_variable_set(("@" + classification).to_sym, classifide.send(classification))
		end
	end

	def remove_date
		@clean_profession = @text.gsub(regex_dates, "")
	end

	def remove_city
		@clean_profession.gsub!(regex_cities, "")
	end	

	def remove_institution
		@clean_profession.gsub!(regex_companies, "")
		@clean_profession.gsub!(regex_schools, "")
	end

	def get_professions
		@clean_profession.gsub!(regex_companies, "")
	end

	def remove_all_but_profession
		@clean_profession = @clean_profession[regex_professions]
	end


    def season?
    	!@text[regex_season].nil?
	end

    def split_date
    	@prepare_split_date = @dates.gsub(Regexp.new('( |)(to\\b|-|–)( |)', 'i'), "{+)")
    	@split_date = @prepare_split_date.split("{+)")
    	if @split_date.kind_of?(Array)
    		@split_date
    	else
    		@split_date = [@dates]
    	end
    end

    def start_time_text?
    	if date?
	    	split_date[0]
	    end
    end

    def start_time_number
    	if date?
			@start_time_number = start_year.to_i + convert_month_to_number(start_month)
		else 
			nil
		end
    end

    def end_time_text?
    	if @end_time_text.nil?
	    	if date?
		    	if end_date_exists?
		    		@end_time_text = split_date[1]
		    	end
		    end
		else
			@end_time_text
		end
    end

    def current?

    	!end_time_text?[regex_current].nil?
    end

    def end_time_number
		if date?
			if end_date_exists?
				if current?
					@end_time_number = Date.today.strftime("%Y").to_i + (Date.today.strftime("%m")).to_i/12
				else
					@end_time_number = end_year.to_i + convert_month_to_number(end_month)
				end
			end
		end
    end

    def end_date_exists?
    	split_date.length == 2
    end

    def start_year
    	@start_year = split_date[0][regex_year]
    end

    def start_month
    	@start_month = split_date[0][regex_month]
    	if @start_month.nil?
    		@start_month = split_date[0][regex_season]
	    	if @start_month.nil?
	    		@start_month = "Jan"
	    	end
	    end
	    @start_month
	end

    def end_year
    	@end_year = split_date[1][regex_year]
    end

    def end_month
    	if @end_month.nil?
    		@end_month = split_date[1][regex_month]
    		if @end_month.nil?
    			@end_month = "Jan"
    		end
    		@end_month
    	else
    		@end_month
    	end
    end

    def duration
    	if season?
    		@duration = 3/12
    	else
    		@duration = end_time_number - start_time_number
    	end
    end

    def convert_season_to_number(season)
    	case season.downcase
    		when "winter"
    			0
    		when "spring"
    			3
    		when "summer"
    			6
    		when "fall"
    			9
    	end
    end

    		
    def convert_month_to_number(month)
    	if season?
			@converted_month = convert_season_to_number(month)
		else
			@converted_month = Date::ABBR_MONTHNAMES.index(month[0..2])
		end
		
		@converted_month_of_12 = (@converted_month / 12).to_f
	end

	def split_cities
		@location = @cities.split(", ")
	end

	def just_city

		split_cities[0]
	end

	def just_state
		split_cities[1]
	end

end