module GetWords
	def get_words response
    body=response.body_str
	  js = JSON.parse(body)
	  js['words'].sort
	end
end