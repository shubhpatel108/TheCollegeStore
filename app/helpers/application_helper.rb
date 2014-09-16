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

	def title(page_title)
	  content_for(:title) { " | " + page_title }
	end

	def amazon_link(isbn13)
		isbn10 = isbn13to10(isbn13)
		return "http://www.amazon.in/dp/product/#{isbn10}/?tag=thecolsto-21"
	end

	def isbn13to10(isbn_)
		isbn = isbn_.gsub(/[^0-9xX]/,'').gsub(/x/,'X') unless isbn_.nil? or isbn_.scan(/([xX])/).length > 1
		isbn10 = isbn[3..11] +  compute_isbn10_check_digit(isbn[3..11]) unless isbn.nil? or ! isbn_.match(/^978.*/)
	end

	def compute_isbn10_check_digit(isbn)
		return nil if isbn.nil? or isbn.length > 10 or isbn.length < 9
		sum = 0;
		0.upto(8) { |ndx| sum += isbn[ndx].chr.to_i * (10-ndx) }
		(11-sum) % 11 == 10 ? "X" : ((11-sum) % 11).to_s
	end
end
