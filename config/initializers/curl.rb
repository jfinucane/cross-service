require 'curb'

if ['development', 'test'].include? Rails.env
	class Curl::Easy
	  def parsed
	    JSON.parse(self.body_str)
	  end
	end
end