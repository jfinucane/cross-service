class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'json'

 def find_or_create_word processed, word, dictionary_id
  Word.find_or_create_by_processed_and_word_and_dictionary_id(
    processed, word, dictionary_id)
 end



  def sort_chars word
	  word.each_char.map{|c|c}.sort.join('')    
  end

  def validate_dictionary
    @anagrams = params.dup
    @dictionary, @using_default = Dictionary.find_or_default(params)
    if @word = (params['word'] || params['id'])
      @anagrams['word'] =  @word.downcase
      @anagrams['sorted_word'] = sort_chars @word
    end
  end
end
