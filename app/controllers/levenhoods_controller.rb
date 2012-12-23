class LevenhoodsController < ApplicationController
  include ApplicationHelper
  before_filter :validate_dictionary

  # GET /levenhoods/1
  # GET /levenhoods/1.json
  def show
    neighbor = params[:id].downcase.gsub(/\*/,'')
    @levenhood = Levenhood.find_by_neighbor_and_dictionary_id(neighbor, @dictionary.id)
    @js = @levenhood && JSON.parse(@levenhood.try(:words)) || []
    @js << neighbor if Word.find_by_word_and_dictionary_id(neighbor, @dictionary.id)
    @cols = column_count @js.count, @word.length
    @method = 'Spelling help'
    self.formats=[:html]
    partial = render_to_string(:partial=>'layouts/plain') if params[:callback]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback_or_list(@js,partial) }
    end
  end
end
