class AutocompletionsController < ApplicationController
  include ApplicationHelper
  before_filter :validate_dictionary
  # GET /autocompletions
  # GET /autocompletions.json
  def index
    @autocompletions = [Autocompletion.first]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @autocompletions }
    end
  end

  def get_autocomplete params
    @prefix = params[:id].downcase.gsub(/\*/,'')
    word = Word.find_by_word_and_dictionary_id(@prefix, @dictionary.id)
    completions = @good_word = word && [word.word] || []
    @autocompletion = Autocompletion.find_by_prefix_and_dictionary_id(@prefix, @dictionary.id)
    completions += JSON.parse(@autocompletion.words) if @autocompletion
    completions
  end

  # GET /autocompletions/1
  # GET /autocompletions/1.json
  def show
    @js = get_autocomplete params
    @cols = column_count @js.count, 20
    @method = 'Autocompletions'
    self.formats=[:html]
    partial = render_to_string(:partial=>'layouts/plain') if params[:callback]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback_or_list(@js, partial), layout:false }
    end
  end

  # GET /autocompletions/1
  # GET /autocompletions/1.json
  def autospell
    completions = get_autocomplete params
    if @dictionary.name == 'sowpods'
      spell_dict_name = 'sowpops_with_spellcheck'
    else
      spell_dict_name = @dictionary.name + '_with_spellcheck'
    end  
    spell_dict = Dictionary.find_by_name(spell_dict_name)
    auto = spell_dict && Autocompletion.find_by_prefix_and_dictionary_id(@prefix, spell_dict.id)
    if auto
      spell_completions = JSON.parse(auto[:words]) 
      completions <<  ' -maybe?-' 
      completions += spell_completions.map{|score|score[1]} - @good_word
    end 
    @js = completions
    @cols = 3
    @method = 'Autocompletions/Spelling suggestions'
    self.formats=[:html]
    partial = render_to_string(:partial=>'layouts/plain') if params[:callback]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: callback_or_list(@js, partial), layout:false }
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
    autocomplete = params[:autocompletion]
    @dictionary = Dictionary.find_by_name(params[:dictionary])

    if @dictionary
      autocomplete = JSON.parse autocomplete if autocomplete.class == String # because of curb
      if autocomplete.is_a? Hash 
        @autocompletion = Autocompletion.create_in_dictionary autocomplete, @dictionary.id
      else
        autocomplete.each do |auto_array|
          auto_hash = {prefix: auto_array[0], words: auto_array[1].to_json}
          @autocompletion = Autocompletion.create_in_dictionary auto_hash, @dictionary.id
        end
      end
    end
    respond_to do |format|
      if @dictionary && @autocompletion
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
