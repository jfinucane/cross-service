module ValidDictionary 
  def get_array response
    body=response.body_str
	js = JSON.parse(body)
    js.sort
  end

  def get_words response
	js = JSON.parse(response.body_str)
    js['words'].sort
end
  def whoops
  	puts 'debugging message'
  	'ERROR'
  end
end