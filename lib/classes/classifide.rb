

class Classifide
    	
    attr_accessor *both_classifications_symboled

	def initialize(classifide)
		both_classifications.each do |classification|
			instance_variable_set(("@" + classification).to_sym, classifide[classification.to_sym])
		end
	end

    def more_words_than?(number)
        @number_of_words > number
    end

    def name?
        @name.nil?  
    end

	def many_words?
		@many_words
	end

    def email?
        !@email.nil?
    end    

    def type?
        @type.nil?
    end

    def address?
       !@address.nil? 
    end

    def phone?
       !@phone.nil? 
    end

    def verbs?
       !@verbs.nil? 
    end

    def date?
        if @dates.nil? and @dates_2.nil?
            false
        else
            true
        end
    end

    
    def institution?
       if @schools.nil? and @companies.nil?
            false
        else
            true
        end 
    end

    def profession?
       !@professions.nil? 
    end

    def city?
       !@cities.nil?
    end

    def section?
        !@section.nil?
    end

	def set_new_value(attribute, new_value)
		instance_variable_set(("@" + attribute).to_sym, new_value)
	end

    def children
        @presume.all_types[@id].drop(1)     
    end
end