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
end
