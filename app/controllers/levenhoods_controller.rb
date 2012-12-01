class LevenhoodsController < ApplicationController
  # GET /levenhoods
  # GET /levenhoods.json
  before_filter :validate_dictionary
  def index
    @levenhoods = Levenhood.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @levenhoods }
    end
  end

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

  # GET /levenhoods/new
  # GET /levenhoods/new.json
  def new
    @levenhood = Levenhood.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @levenhood }
    end
  end

  # GET /levenhoods/1/edit
  def edit
    @levenhood = Levenhood.find(params[:id])
  end

  # POST /levenhoods
  # POST /levenhoods.json
  def create
    @levenhood = Levenhood.new(params[:levenhood])

    respond_to do |format|
      if @levenhood.save
        format.html { redirect_to @levenhood, notice: 'Levenhood was successfully created.' }
        format.json { render json: @levenhood, status: :created, location: @levenhood }
      else
        format.html { render action: "new" }
        format.json { render json: @levenhood.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /levenhoods/1
  # PUT /levenhoods/1.json
  def update
    @levenhood = Levenhood.find(params[:id])

    respond_to do |format|
      if @levenhood.update_attributes(params[:levenhood])
        format.html { redirect_to @levenhood, notice: 'Levenhood was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @levenhood.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /levenhoods/1
  # DELETE /levenhoods/1.json
  def destroy
    @levenhood = Levenhood.find(params[:id])
    @levenhood.destroy

    respond_to do |format|
      format.html { redirect_to levenhoods_url }
      format.json { head :no_content }
    end
  end
end
