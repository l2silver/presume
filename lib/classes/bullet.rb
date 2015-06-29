class Bullet < Header

	attr_accessor :text, :id

	def initialize(classifide, header)
	
		both_classifications.each do |classification|
			instance_variable_set(("@" + classification).to_sym, header.send(classification))
		end

		@header_text = @text
		@header_id = @id
		
		@text = classifide.text
		@id = classifide.id
	end

end