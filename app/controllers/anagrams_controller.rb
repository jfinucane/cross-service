require 'redis'
class AnagramsController < ApplicationController
require 'suggestions.rb'
include Suggestions
include ApplicationHelper
before_filter :validate_dictionary

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

  def word_list wildcard
    result = JSON.parse(wildcard.words)
    result.to_a[100] = " -#{result.count-100} more" if result.count > 100 
    result.to_a[0,101] 
  end

  # GET /anagrams.json/word
  def show 
    word = @anagrams[:sorted_word]
    wc = Wildcards.find_by_word(word)
    @js = wc ? word_list(wc) : []
    @cols = column_count @js.count, @word.length
    @method = 'Anagrams'
    self.formats=[:html]
    partial = render_to_string(:partial=>'layouts/plain') if params[:callback]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback_or_list(@js, partial), layout:false }
    end
  end   

  def suggestions
    s=SingleDifference.new @dictionary.id
    start_time = Time.now
    @suggestions = s.suggestions @word.downcase.gsub(/\*/,'')
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
