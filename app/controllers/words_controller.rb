class WordsController < ApplicationController
  require 'response_parser'
  include ResponseParser
  before_filter :valid_dictionary

  def get_page words, params
    @offset = (params['start'] || params['offset']).to_i
    @page_size = params['page_size'] ? params['page_size'].to_i : 300
    @words = []
    words.offset(@offset).limit(@page_size).each do |w|
      @words << w.word
    end
    if @offset + @page_size < words.count 
      next_host = request.host 
      next_host += ':3000' if next_host =~ /localhost/
      @forward = '//' + next_host + "/" + @prefix + 
        '?dictionary=' + @dict_string + '&offset=' + (@offset +@page_size).to_s
    end
    @words
  end

  def dictionary_words 
    @dictionary_words = Word.order('word').where(:processed=>0, :dictionary_id => @dictionary_id)
  end
  def index
    @prefix='words'  
    @page = get_page dictionary_words, params
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @page.to_json }
    end
  end

  # POST /words, POST /words.json
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
    puts "DISPLAY API DOCS #{request.domain}, #{request.subdomain}"
    file = File.open(File.expand_path('../../../README.rdoc', __FILE__), 'r')
    @lines = file.read.split("\n")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def startswith
    @prefix = params[:id] 
    @words = dictionary_words.where('word like ?', @prefix + '%')
    @page = get_page @words, params
    respond_to do |format|
      format.html # startswith.html.erb
      format.json { render json: @page.to_json }
    end
  end

  def contains
    @prefix = params[:id]
    @words = dictionary_words.where('word like ?', '%' + @prefix + '%')
    @page = get_page @words, params
    respond_to do |format|
      format.html # startswith.html.erb
      format.json { render json: @page.to_json }
    end
  end

end
