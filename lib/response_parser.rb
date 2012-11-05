module ResponseParser
  def get_array response
    begin
	    js = JSON.parse(response.body_str)
      js.sort
    rescue
      []
    end
  end

  def get_words response
    begin
	    js = JSON.parse(response.body_str)
      js['words'].sort
    rescue
      []
    end
  end

  def get_keys response
    begin
      js=JSON.parse(response.body_str)
      js.keys
    rescue
      []
    end
  end
    
  def whoops
  	puts 'debugging message'
  	'ERROR'
  end

  def create_word dict, word_list
    word_list.each{|word|
      @args = {:dictionary=>dict, :word=> word}
      Curl.post HOST+'/anagrams.json', @args
    }
  end

  def sort_chars word
    word.chars.sort.join('')    
  end

end