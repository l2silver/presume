class ResumeBuilder

    attr_accessor :classifides, :resume

    def initialize(classified_lines)
        @classifides = classified_lines
        @length = classified_lines.length
    end

    def set_classifide(line_number)
        @classifide = @classifides[line_number]
        @line_number = line_number
    end

    def header_line_number?
        ((@line_number + 1)/@length).to_f <= 0.10
    end

    def check_for_name_in_header
        if !@classifide.many_words? and !@classifide.name? and @classifide.type?   
            @classifide.type = "name"
        end
    end

    def check_for_email_in_header
        if !@classifide.many_words? and @classifide.email? and @classifide.type?
            @classifide.type = "email"
        end
    end

    def check_for_address_in_header
        if @classifide.address? and @classifide.type?
            @classifide.type = "address"
        end
    end

    def check_for_phone_in_header
        if !@classifide.many_words? and @classifide.phone? and @classifide.type?
            @classifide.type = "phone"
        end
    end

    def check_header
        if header_line_number?
            check_for_name_in_header
            check_for_email_in_header
            check_for_address_in_header
            check_for_phone_in_header
        end
    end

    def classifide_after
        if @line_number == @length - 1
            @classifide_after = @classifides[@line_number]
        else
            @classifide_after = @classifides[@line_number + 1] 
        end
    end

    def classifide_after_after
        if @line_number >= @length - 2
            @classifide_after = @classifides[@line_number]
        else
            @classifide_after = @classifides[@line_number + 2] 
        end
    end

    def classifide_before
        @classifide_before = @classifides[@line_number - 1]
    end

    def check_obvious_types

        if !@classifide.institution? and @classifide.type? and !@classifide.date? and !@classifide.city? and !@classifide.profession? and !@classifide.many_words? and @classifide.section?
            @classifide.type = "section"
        end

        if @classifide.many_words? and @classifide.verbs? and @classifide.type? and !@classifide.date?
            @classifide.type = "bullet"
        end

        if !@classifide.institution? and @classifide.type? and !@classifide.date? and !@classifide.city? and !@classifide.profession? and !@classifide.section?
            @classifide.type = "bullet"
        end

        if @classifide.institution? and @classifide.type? and @classifide.date? and @classifide.city? and @classifide.profession?
            @classifide.type = "header"
        end

        if @classifide.type? and ((@classifide.institution? and @classifide.date? and @classifide.city? and @classifide.profession?) or (@classifide.institution? and @classifide.date? and @classifide.city?) or (@classifide.institution? and @classifide.date? and !@classifide.many_words?) or (@classifide.date? and @classifide.city? and @classifide.profession? and !@classifide.many_words?))
            @classifide.type = "header_x"
        end 

        if @classifide.type? and @classifide.many_words? and !@classifide.verbs? and (@classifide.profession? or @classifide.city? or @classifide.institution?)
            @classifide.type = "header_x"    
        end            

    end


    def first_pass
        @length.times do |n|
            set_classifide(n)
            check_header
            check_obvious_types
        end
    end

    def second_pass
        @length.times do |n|
            set_classifide(n)
            if !@classifide.institution? and @classifide.type? and !@classifide.date? and !@classifide.city? and !@classifide.profession? and !@classifide.many_words?
                if (@classifide_after.institution? and @classifide_after.profession?) or (!@classifide_after.institution? and !@classifide_after.profession?)
                    @classifide.type = "section"
                end
            end

            if (@classifide.institution? or @classifide.profession?) and !@classifide.many_words? and @classifide.type?
              @classifide.type = "header_x"                
            end

            if !@classifide.institution? and @classifide.profession? and  @classifide.type?
              @classifide.type = "header_x"                
            end

            if @classifide.type? and @classifide.more_words_than?(10)
              @classifide.type = "bullet"                
            end


        end
    end

    def reset_header_x_start
        @header_x_start = true
    end

    def build_resume
        reset_header_x_start
        @length.times do |n|
            set_classifide(n)        
            unless @classifide.type?
                unless @classifide.type == "name" or @classifide.type == "email" or @classifide.type == "phone" or @classifide.type == "address"
                    send(@classifide.type + "_build")
                end
            end 
        end            
    end

    def add_to_all_types(id)
        if all_types[id].nil?
            all_types[id] = [@all_type]
        else
            all_types[id] += [@all_type]
        end
    end

    def section_build
        @header_number = nil
        @header_x_start = true
        @section_number = @line_number
        @all_type = @classifide
        add_section_to_resume
    end

    def add_section_to_resume
        sections.merge!({@line_number => @all_type})
        add_to_all_types(@line_number)
    end

    def add_header_to_resume
        headers.merge!({@line_number => @header})
        
        add_to_all_types(@line_number)
        add_to_all_types(@section_number)
    end

    def add_bullet_to_resume
        bullets.merge!({@line_number => @bullet})
        add_to_all_types(@line_number)
        add_to_all_types(header_number?)
    end
    
    def section_number?
        if @section_number.nil?
            @section_number = -1

        else
            @section_number
        end
    end

    def previous_section_headers?
        !headers[@section_number].nil?
    end

    def header_build
        @bullet = nil
        @header_number = @line_number
        @header = Header.new(@classifide)
        @header_x_start = true
        @all_type = @header
        add_header_to_resume
    end

    def create_blank_classifide
        @blank_classifide = Classifide.new(id: -1)
    end
    def bullet_parent
        if all_types[header_number?].nil?
            @all_type = create_blank_classifide
            add_to_all_types(-1)
            all_types[-1][0]
        else
            all_types[header_number?][0]
        end
    end

    def bullet_build
        @header_x_start = true
        @bullet = Bullet.new(@classifide, bullet_parent)
        @all_type = @bullet
        add_bullet_to_resume
    end

    def header_number?
        if @header_number.nil?
            section_number?
        else
            @header_number
        end
    end

    def check_for_gaps
        header_classifications.each do |classification|
                if @classifide.send(classification).nil?
                    if !classifide_after_after.send(classification).nil?
                        @classifide.set_new_value(classification, classifide_after_after.send(classification))
                    @header_x_start = "almost"    
                    end
                end
            end
    end

    def combine_text()

    end
    
    def header_x_build
        
        @header_number = @line_number
        if @header_x_start == true
            if classifide_after.type == "header_x"
                header_classifications.each do |classification|
                    if @classifide.send(classification).nil?
                        @classifide.set_new_value(classification, classifide_after.send(classification))
                    end
                end


                @classifide.set_new_value("text", @classifide.text + ", " + classifide_after.text)

                if classifide_after_after.type == "header_x"
                    check_for_gaps
                    if @header_x_start == 'almost'
                        @classifide.set_new_value("text", @classifide.text + ", " + classifide_after_after.text)
                    end

                    @header_x_start = false unless @header_x_start == "almost"
                else
                    
                    
                    
                    @header_x_start = false
                end

            end
            @header = Header.new(@classifide)
            @all_type = @header
            add_header_to_resume

        else
            if @header_x_start == "almost"
                @header_x_start == "almost_closer"
            else
                @header_x_start = true
            end
        end
    end    

    def resume
        resume = {sections: sections, headers: headers, bullets: bullets, all_types: all_types}
    end

    def sections
        @sections ||= {}
    end

    def headers
        @headers ||= {}
    end

    def bullets
        @bullets ||= {}
    end

    def all_types
       @all_types ||= {}
    end
=begin
        @length.times do |n|

            set_classifide(n)

            if type?

            #check following types
                if n < @n - 2 and n > 1
                    
                    if !many_words? and @p_hash[n+1][:type] == "resume_post"  and @p[:type].nil?
                        @p[:type] = "resume_group"    
                    end

                    if @p[:word_length] == false and @p_hash[n+1][:type] == "resume_post_x" and @p_hash[n-1][:type] != "resume_post_x"  and @p[:type].nil?
                        @p[:type] = "resume_group"    
                    end
                    if @p[:word_length] == false and @p_hash[n+1][:type] == "resume_line" and /resume_post/.match(@p_hash[n-1][:type]).nil? and @p[:type].nil?
                        @p[:type] = "resume_group"    
                    end
                end
            end
        end

    #pass 4

        (@n -1).times do |n|

            @p = @p_hash[n]

            if @p[:type].nil?
                #check following types
                if n < @n - 2 and n > 1
                    
                    if (@p_hash[n+1][:type] == "resume_post" or @p_hash[n+1][:type] == "resume_group") and @p_hash[n-1][:type] == "resume_post"  and @p[:type].nil?
                        @p[:type] = "resume_line"    
                    end

                    if @p_hash[n-1][:type] == "resume_post" and @p_hash[n+1][:type] == "resume_line"  and @p[:type].nil?
                        @p[:type] = "resume_post_x"
                    end
                end
            end
        end
=end

=begin
        @current_user_2 = current_user
        #@current_user_2 = User.find(2)
        @resume_line_shoot = 0
        @resume_line_build = 0
        (@n -1).times do |n|

            @p = @p_hash[n]

            puts @p[:type]
            unless /resume/.match(@p[:type]).nil?
                puts @p[:type]
                construct_resume_object(args = {n: n, p_hash: @p_hash, resume_group: @resume_group, resume_post: @resume_post, resume_line: @resume_line})
            end
        end

        redirect_to current_user
=end

end
