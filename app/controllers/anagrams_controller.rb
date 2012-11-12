require 'redis'
class AnagramsController < ApplicationController
require 'suggestions.rb'
include Suggestions
before_filter :validate_dictionary

  # GET /anagrams
  # GET /anagrams.json
  def showdb
    sorted = Word.where(:processed => 1, 
      :word => @anagrams['sorted_word'], 
      :dictionary_id => @dictionary.id).limit(1)
    sorted_id = sorted.first.id if sorted.count > 0
    if sorted_id
       anagrams = Anagram.where(:sorted_id => sorted_id)
       @anagrams['words'] = anagrams.map{|anagram|  Word.find_by_id(anagram.word_id).word }
       @anagrams[:status] = 'success'    
    else
       @anagrams[:status] = 'no anagrams found'
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback(@anagrams), layout:false }
    end
  end

  # POST /anagrams
  # POST /anagrams.json
  def create
    unless @using_default
      word=find_or_create_word(0, @anagrams['word'], @dictionary.id)
      sorted= find_or_create_word(1, @anagrams['sorted_word'], @dictionary.id)
      a = Anagram.find_or_create_by_word_id_and_sorted_id(word.id, sorted.id)   
      @anagrams[:status] = 'success'
      anagrams_key = "anag:#{@dictionary.id.to_s}:#{@anagrams['sorted_word']}"
      REDIS.sadd anagrams_key, @anagrams['word']
    else
      @anagrams[:status] = 'provide a valid dictionary' 
    end  
    respond_to do |format|
      format.json { render json: @anagrams.to_json, layout: false}
    end
  end

  # GET /anagrams.json/word
  def show
    anagrams_key="anag:#{@dictionary.id.to_s}:#{@anagrams[:sorted_word]}"
    @js = REDIS.smembers anagrams_key
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback(@js), layout:false }
    end
  end   

  def suggestions
    s=SingleDifference.new @dictionary.id
    start_time = Time.now
    @suggestions = s.suggestions @word
    if params[:callback]
      @suggestions = render_to_string(:partial=>'anagrams/suggestions_table', 
        :formats=>'html',
        :locals=>{:suggestions=> @suggestions})
      @suggestions = '<span>' + @suggestions.gsub(/\n/,'') + '</span>'
    end
    end_time = Time.now
    @elapsed_time = end_time - start_time
    respond_to do |format|
      format.html
      format.json { render json: callback(@suggestions), layout:false}
    end
  end

end
