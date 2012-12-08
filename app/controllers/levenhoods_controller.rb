class LevenhoodsController < ApplicationController
  # GET /levenhoods
  # GET /levenhoods.json
  before_filter :validate_dictionary

  # GET /levenhoods/1
  # GET /levenhoods/1.json
  def show
    neighbor = params[:id].downcase.gsub(/\*/,'')
    @levenhood = Levenhood.find_by_neighbor_and_dictionary_id(neighbor, @dictionary.id)
    @js = @levenhood && JSON.parse(@levenhood.try(:words)) || []
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback(@js) }
    end
  end
end
