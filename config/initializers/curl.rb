

if ['development', 'test'].include? Rails.env
  require 'curb'
	class Curl::Easy
	  def parsed
	    JSON.parse(self.body_str)
	  end
	end
end