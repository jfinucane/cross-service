class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'json'

   def find_or_create_word processed, word, dictionary_id
    Word.find_or_create_by_processed_and_word_and_dictionary_id(
      processed, word, dictionary_id)
  end

    def valid_dictionary
    @anagrams = params.dup
    @dictionary_id = nil
    if @dict_string = params['dictionary']
      dictionary = Dictionary.where(:name=>@dict_string.downcase)
      if  dictionary && dictionary.count > 0
        @dictionary_id = dictionary.first.id
        if word = params['word']
          @anagrams['word'] =  word.downcase
          @anagrams['sorted_word'] = sort_chars word
        end
      else
        @anagrams[:status] = 'bad dictionary parameter'
      end
    else
      @anagrams[:status] = 'missing dictionary parameter'
    end
  end

  def sort_chars word
	  word.each_char.map{|c|c}.sort.join('')    
  end


end
