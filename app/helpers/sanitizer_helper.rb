module SanitizerHelper
	def sanitize_hash(hash)
		return hash.update(hash){|key,value|
			if value.class == ActiveSupport::HashWithIndifferentAccess
				sanitize_hash(value)
			else
				sanitize(value)
			end
			}
	end

	def sanitize(text)
		$full_sanitizer.sanitize(text.strip)
	end
end