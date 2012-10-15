class WordsController < ApplicationController
  require 'valid_dictionary'
  include ValidDictionary
  before_filter :valid_dictionary
  # GET /words
  # GET /words.json
  def index
    offset = params['start'].to_i
    ps = params['page_size'].to_i
    page_size = ps > 0 ? ps : 100
    @words = []
    rel = Word.order('word').where(:processed=>0, :dictionary_id => @dictionary_id)
    rel.offset(offset).limit(page_size).each do |w|
      @words << w.word
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words.to_json }
    end
  end

  # POST /words
  # POST /words.json
  def create
    
    if @dictionary_id
      word = find_or_create_word(0, @anagrams['word'], @dictionary_id)
      @anagrams[:status] = 'success'
    end

    respond_to do |format|
      format.json { render json: @anagrams.to_json, layout: false}
    end
  end


  def api

    @display_cols = 10
    file = File.open(File.expand_path('../../../README.rdoc', __FILE__), 'r')
    @lines = file.read.split("\n")
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

end
