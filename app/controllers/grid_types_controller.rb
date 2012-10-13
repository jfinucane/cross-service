class GridTypesController < ApplicationController
  # GET /grid_types
  # GET /grid_types.json
  def index
    @grid_types = GridType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grid_types }
    end
  end

  # GET /grid_types/1
  # GET /grid_types/1.json
  def show
    @grid_type = GridType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grid_type }
    end
  end

  # GET /grid_types/new
  # GET /grid_types/new.json
  def new
    @grid_type = GridType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grid_type }
    end
  end

  # GET /grid_types/1/edit
  def edit
    @grid_type = GridType.find(params[:id])
  end

  # POST /grid_types
  # POST /grid_types.json
  def create
    @grid_type = GridType.new(params[:grid_type])

    respond_to do |format|
      if @grid_type.save
        format.html { redirect_to @grid_type, notice: 'Grid type was successfully created.' }
        format.json { render json: @grid_type, status: :created, location: @grid_type }
      else
        format.html { render action: "new" }
        format.json { render json: @grid_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grid_types/1
  # PUT /grid_types/1.json
  def update
    @grid_type = GridType.find(params[:id])

    respond_to do |format|
      if @grid_type.update_attributes(params[:grid_type])
        format.html { redirect_to @grid_type, notice: 'Grid type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @grid_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grid_types/1
  # DELETE /grid_types/1.json
  def destroy
    @grid_type = GridType.find(params[:id])
    @grid_type.destroy

    respond_to do |format|
      format.html { redirect_to grid_types_url }
      format.json { head :no_content }
    end
  end
end
