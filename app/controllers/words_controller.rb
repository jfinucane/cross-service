class WordsController < ApplicationController
  require 'response_parser'
  include ResponseParser
  include ApplicationHelper
  before_filter :validate_dictionary

  def get_page words, params
    @offset = (params['start'] || params['offset']).to_i
    @page_size = params['page_size'] ? params['page_size'].to_i : 200
    word_list = []
    words.offset(@offset).limit(@page_size).each do |w|
      word_list << w.word
    end
    if @offset + @page_size < words.count 
      next_host = request.host 
      next_host += ':3000' if next_host =~ /localhost/
      @forward = '//' + next_host + "/" + @prefix + 
        '?dictionary=' + @dictionary.name + '&offset=' + (@offset +@page_size).to_s
    end
   word_list
  end

  def dictionary_words 
    @dictionary_words = Word.order('word').where(:processed=>0, :dictionary_id => @dictionary.id)
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
    if @dictionary.id
      word = find_or_create_word(0, @anagrams['word'], @dictionary.id)
      @anagrams[:status] = 'success'
    end
    respond_to do |format|
      format.json { render json: @anagrams.to_json, layout: false}
    end
  end

  def api
    file = File.open(File.expand_path('../../../README.rdoc', __FILE__), 'r')
    @lines = file.read.split("\n")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lines }
    end
  end

  def startswith
    @prefix = params[:id].downcase.gsub(/\*/,'')
    @words = dictionary_words.where('word like ?', @prefix + '%')
    @page = get_page @words, params
    @cols = column_count @page.count, 10
    @method = 'StartsWith'
    self.formats=[:html]
    @js = @page
    partial = render_to_string(:partial=>'layouts/plain') if params[:callback]
    respond_to do |format|
      format.html # startswith.html.erb
      format.json { render json: callback_or_list(@page, partial) }
    end
  end

  def contains
    @prefix = params[:id].downcase.gsub(/\*/,'')
    @words = dictionary_words.where('word like ?', '%' + @prefix + '%')
    @page = get_page @words, params
    @cols = column_count @page.count, 10
    @method = 'Contains'
    self.formats=[:html]
    @js = @page
    partial = render_to_string(:partial=>'layouts/plain') if params[:callback]
    respond_to do |format|
      format.html # startswith.html.erb
      format.json { render json:  callback_or_list(@page,partial) }
    end
  end

  def about
    respond_to do |format|
      format.html # index.html.erb
    end
  end 

  def help
    respond_to do |format|
      format.html # index.html.erb
    end
  end


end
