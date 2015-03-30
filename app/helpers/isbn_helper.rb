module IsbnHelper

	def get_isbn(book_group_id)
		case book_group_id
		when 88
			"9780201662108"
		when 130
			"9780062095909"
		when 131
			"9788129135728"
		when 132
			"9780399252518"
		when 133
			"9781476731353"
		when 137
			"9788189975814"
		else
			nil
		end
	end
	
end
