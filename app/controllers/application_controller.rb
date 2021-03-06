class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'json'

  def find_or_create_word processed, word, dictionary_id
    Word.find_or_create_by_processed_and_word_and_dictionary_id(
    processed, word, dictionary_id)
  end

  def callback js 
    cb = params['callback']
    if cb
      cb + '(' + js.to_json + ')' 
    else 
      js.to_json
    end
  end

  def callback_or_list js, partial 
    cb = params['callback']
    if cb
      cb + '(' + partial.to_json + ')' 
    else 
      js.to_json
    end
  end
  
  def sort_chars word
	  word.chars.sort.join('')    
  end

  def validate_dictionary
    @anagrams = params.dup
    @dictionary, @using_default = Dictionary.find_or_default(params)
    if @word = (params['word'] || params['id'])
      @anagrams['word'] =  @word.downcase
      @anagrams['sorted_word'] = sort_chars @anagrams['word']
    end
  end
end
