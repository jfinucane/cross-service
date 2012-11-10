module Suggestions
	class SingleDifference
    attr_reader :dictionary_id, :words
	  def initialize dictionary_id
	    @dictionary_id = dictionary_id.to_s
	   
	  end
	  def anag_key sorted_word
	    "anag:#{@dictionary_id}:#{sorted_word}"
	  end
	  def addone word
	  	words_by_added_char = Hash.new
	  	('a'..'z').each{|c|
	  	 sorted_word = (word + c).chars.sort.join('')
	  	 #@words += REDIS.smembers anag_key(sorted_word) || []
	  	 words = REDIS.smembers(anag_key(sorted_word)).to_a
	  	 words_by_added_char[c] = words if words && words.count > 0
	  	}
	  	words_by_added_char
	  end
	  def shorten word
	    @shortest = word.length > 9 ? (word.length - 4) : 3 
	  	@words = Set.new
	  	@done = Hash.new 
	    deleteone word[0,12].chars.sort.join('')
      @words
    end
    def deleteone sorted_word
    	return if sorted_word.length < @shortest
	    (0...sorted_word.length).each {|i|
	      temp = sorted_word.dup
	      temp[i]=''
	      @done[temp] ? next : @done[temp] = true
	      @words += REDIS.smembers anag_key(temp) || []       
	      deleteone temp
	    } 
	  end
	  def anagrams word
	    REDIS.smembers anag_key(word.chars.sort.join()) || []
	  end
	  def suggestions word
	  	@result = Hash.new
	  	@result['addone'] = addone word
	  	@result['shorten'] = shorten word
	  	@result['anagrams'] = anagrams word
	    @result
	  end
	end
end