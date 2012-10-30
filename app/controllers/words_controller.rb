class WordsController < ApplicationController
  require 'valid_dictionary'
  include ValidDictionary
  before_filter :valid_dictionary

  def get_page words, params
    offset = (params['start'] || params['offset']).to_i
    ps = params['page_size'].to_i
    page_size = ps > 0 ? ps : 300
    @words = []
    words.offset(offset).limit(page_size).each do |w|
      @words << w.word
    end
    @words
  end

  def dictionary_words 
    @dictionary_words = Word.order('word').where(:processed=>0, :dictionary_id => @dictionary_id)
  end
  def index
    @words = get_page dictionary_words, params
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words.to_json }
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
    @prefix = params[:id] + '%'
    prefixed_words = dictionary_words.where('word like ?', @prefix)
    @prefix_words = get_page prefixed_words, params
    respond_to do |format|
      format.html # startswith.html.erb
      format.json { render json: @prefix_words.to_json }
    end
  end

  def contains
    @prefix = '%' + params[:id] + '%'
    prefixed_words = dictionary_words.where('word like ?', @prefix)
    @prefix_words = get_page prefixed_words, params
    respond_to do |format|
      format.html # startswith.html.erb
      format.json { render json: @prefix_words.to_json }
    end
  end

end
