class PopScoresController < ApplicationController
  # GET /pop_scores
  # GET /pop_scores.json
  def index
    @pop_scores = PopScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pop_scores }
    end
  end

  # GET /pop_scores/1
  # GET /pop_scores/1.json
  def show
    @pop_score = PopScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pop_score }
    end
  end

  # GET /pop_scores/new
  # GET /pop_scores/new.json
  def new
    @pop_score = PopScore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pop_score }
    end
  end

  # GET /pop_scores/1/edit
  def edit
    @pop_score = PopScore.find(params[:id])
  end

  # POST /pop_scores
  # POST /pop_scores.json
  def create
    @pop_score = PopScore.new(params[:pop_score])

    respond_to do |format|
      if @pop_score.save
        format.html { redirect_to @pop_score, notice: 'Pop score was successfully created.' }
        format.json { render json: @pop_score, status: :created, location: @pop_score }
      else
        format.html { render action: "new" }
        format.json { render json: @pop_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pop_scores/1
  # PUT /pop_scores/1.json
  def update
    @pop_score = PopScore.find(params[:id])

    respond_to do |format|
      if @pop_score.update_attributes(params[:pop_score])
        format.html { redirect_to @pop_score, notice: 'Pop score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pop_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pop_scores/1
  # DELETE /pop_scores/1.json
  def destroy
    @pop_score = PopScore.find(params[:id])
    @pop_score.destroy

    respond_to do |format|
      format.html { redirect_to pop_scores_url }
      format.json { head :no_content }
    end
  end
end
