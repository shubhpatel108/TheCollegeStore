module IsbnHelper

	def get_isbn(book_group_id)
		case book_group_id
		when 88
			"9780201662108"
		else
			nil
		end
	end

end