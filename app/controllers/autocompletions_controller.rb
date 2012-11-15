class AutocompletionsController < ApplicationController
  # GET /autocompletions
  # GET /autocompletions.json
  def index
    @autocompletions = Autocompletion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @autocompletions }
    end
  end

  # GET /autocompletions/1
  # GET /autocompletions/1.json
  def show
    @autocompletion = Autocompletion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @autocompletion }
    end
  end

  # GET /autocompletions/new
  # GET /autocompletions/new.json
  def new
    @autocompletion = Autocompletion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @autocompletion }
    end
  end

  # GET /autocompletions/1/edit
  def edit
    @autocompletion = Autocompletion.find(params[:id])
  end

  # POST /autocompletions
  # POST /autocompletions.json
  def create
    @autocompletion = Autocompletion.new(params[:autocompletion])

    respond_to do |format|
      if @autocompletion.save
        format.html { redirect_to @autocompletion, notice: 'Autocompletion was successfully created.' }
        format.json { render json: @autocompletion, status: :created, location: @autocompletion }
      else
        format.html { render action: "new" }
        format.json { render json: @autocompletion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /autocompletions/1
  # PUT /autocompletions/1.json
  def update
    @autocompletion = Autocompletion.find(params[:id])

    respond_to do |format|
      if @autocompletion.update_attributes(params[:autocompletion])
        format.html { redirect_to @autocompletion, notice: 'Autocompletion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @autocompletion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autocompletions/1
  # DELETE /autocompletions/1.json
  def destroy
    @autocompletion = Autocompletion.find(params[:id])
    @autocompletion.destroy

    respond_to do |format|
      format.html { redirect_to autocompletions_url }
      format.json { head :no_content }
    end
  end
end
