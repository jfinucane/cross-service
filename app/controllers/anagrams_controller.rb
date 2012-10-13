require 'redis'
class AnagramsController < ApplicationController

  before_filter :valid_dictionary, :except => :show
  # GET /anagrams
  # GET /anagrams.json
  def index
    if @dictionary_id
      sorted = Word.where(:processed => 1, 
        :word => @anagrams['sorted_word'], 
        :dictionary_id => @dictionary_id).limit(1)
      sorted_id = sorted.first.id if sorted.count > 0
      if sorted_id
         anagrams = Anagram.where(:sorted_id => sorted_id)
         @anagrams['words'] = anagrams.map{|anagram|  Word.find_by_id(anagram.word_id).word }
         @anagrams[:status] = 'success'
        
      else
         @anagrams[:status] = 'no anagrams found'
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @anagrams.to_json, layout:false }
    end
  end


  # POST /anagrams
  # POST /anagrams.json
  def create
    if @dictionary_id
      word=find_or_create_word(0, @anagrams['word'], @dictionary_id)
      sorted= find_or_create_word(1, @anagrams['sorted_word'], @dictionary_id)
      a = Anagram.find_or_create_by_word_id_and_sorted_id(word.id, sorted.id)   
      @anagrams[:status] = 'success'
      anagrams_key = "anagrams:#{@dict_string}:#{@anagrams['sorted_word']}"
      REDIS.sadd anagrams_key, @anagrams['word']
    end
    
    respond_to do |format|
      format.json { render json: @anagrams.to_json, layout: false}
    end
  end
  #demo purposes
  # GET /anagrams.json/word
  def show
    sorted_word= sort_chars params['id']
    dictionary = params['dictionary'] || 'sowpops'
    anagrams_key="anagrams:#{dictionary}:#{sorted_word}"
    js = REDIS.smembers anagrams_key
    puts 'HOSTHOST HOST ', request.host
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: js.to_json, layout:false }
    end
  end   

end
