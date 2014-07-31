module ApplicationHelper
	def superscript(number)
		number %= 10
		case number
		when 1
			return "st"
		when 2
			return "nd"
		when 3
			return "rd"
		else
			return "th"
		end
	end

	def flipkart_link(isbn)
		return "http://www.flipkart.com/search/a/books?query="+"#{isbn}"+"&affid=shubhanshu1"
	end
end
