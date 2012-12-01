require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AutocompletionsController do

  before :all do
    @scores = Autoloader.new
    AUTOCOMPLETE = 5
  end

  # This should return the minimal set of attributes required to create a valid
  # Autocompletion. As you add validations to Autocompletion, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:prefix=>'st',:words=>[77, 'score']}
  end

  def valid_attributes_list
    [['st',[77, 'score']], ['sta',[88,'stage']]]
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AutocompletionsController. Be sure to keep this updated too.
  def valid_session
  end


  describe "GET show" do
    before do
      AUTOCOMPLETE = 5
    end
    it "assigns the requested autocompletion as @autocompletion" do
      autocompletion = Autocompletion.create! valid_attributes
      get :show, {:id => 'b', dictionary: 'advancedtest'}, valid_session
      assigns(:dictionary).name.should eq('advancedtest')
    end
    it 'checks for "ba"' do 
      get :show, {:id => 'ba', dictionary: 'advancedtest'}, valid_session
      words=JSON.parse(assigns(:autocompletion).words)
      words.should eq(@scores.complete 'ba')
    end
    it 'checks for "ban"' do 
      get :show, {:id => 'ban', dictionary: 'advancedtest'}, valid_session
      words=JSON.parse(assigns(:autocompletion).words)
      words.should eq(@scores.complete 'ban')
    end
    it 'checks for "bant"' do 
      get :show, {:id => 'bant', dictionary: 'advancedtest'}, valid_session
      words=JSON.parse(assigns(:autocompletion).words)
      words.should eq(@scores.complete 'bant')
    end
  end

  describe "GET new" do
    it "assigns a new autocompletion as @autocompletion" do
      get :new, {}, valid_session
      assigns(:autocompletion).should be_a_new(Autocompletion)
    end
  end

  describe "GET edit" do
    it "assigns the requested autocompletion as @autocompletion" do
      autocompletion = Autocompletion.create! valid_attributes
      get :edit, {:id => autocompletion.to_param}, valid_session
      assigns(:autocompletion).should eq(autocompletion)
    end
  end

  describe "POST create" do
    before :each do
      raise unless @id = Dictionary.find_by_name('advancedtest_with_spellcheck').id
      @auto1 = {autocompletion: {prefix: 'bax', words: [100,'baby']}.to_json, 
                dictionary: 'advancedtest_with_spellcheck'}
  
    end
    describe "with valid params" do

      it "creates a new Autocompletion" do
        expect {
          post :create, @auto1, valid_session
        }.to change(Autocompletion, :count).by(1)
      end
      it "creates two new Autocompletions" do
        expect {
          post :create, {:dictionary=>'advancedtest', :autocompletion=>valid_attributes_list}, valid_session
        }.to change(Autocompletion, :count).by(2)
      end

      it "assigns a newly created autocompletion as @autocompletion" do
        post :create, {:dictionary=>'advancedtest', :autocompletion => valid_attributes}, valid_session
        assigns(:autocompletion).should be_a(Autocompletion)
        assigns(:autocompletion).should be_persisted
      end

      it "redirects to the created autocompletion" do
        post :create, {:dictionary=>'advancedtest', :autocompletion => valid_attributes}, valid_session
        response.should redirect_to(Autocompletion.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved autocompletion as @autocompletion" do
        # Trigger the behavior that occurs when invalid params are submitted
        Autocompletion.any_instance.stub(:save).and_return(false)
        post :create, {:dictionary=>'advancedtest', :autocompletion => {}}, valid_session
        assigns(:autocompletion).should be_a_new(Autocompletion)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Autocompletion.any_instance.stub(:save).and_return(false)
        post :create, {:autocompletion => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested autocompletion" do
        autocompletion = Autocompletion.create! valid_attributes
        # Assuming there are no other autocompletions in the database, this
        # specifies that the Autocompletion created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Autocompletion.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => autocompletion.to_param, :autocompletion => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested autocompletion as @autocompletion" do
        autocompletion = Autocompletion.create! valid_attributes
        put :update, {:id => autocompletion.to_param, :autocompletion => valid_attributes}, valid_session
        assigns(:autocompletion).should eq(autocompletion)
      end

      it "redirects to the autocompletion" do
        autocompletion = Autocompletion.create! valid_attributes
        put :update, {:id => autocompletion.to_param, :autocompletion => valid_attributes}, valid_session
        response.should redirect_to(autocompletion)
      end
    end

    describe "with invalid params" do
      it "assigns the autocompletion as @autocompletion" do
        autocompletion = Autocompletion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Autocompletion.any_instance.stub(:save).and_return(false)
        put :update, {:id => autocompletion.to_param, :autocompletion => {}}, valid_session
        assigns(:autocompletion).should eq(autocompletion)
      end

      it "re-renders the 'edit' template" do
        autocompletion = Autocompletion.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Autocompletion.any_instance.stub(:save).and_return(false)
        put :update, {:id => autocompletion.to_param, :autocompletion => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested autocompletion" do
      autocompletion = Autocompletion.create! valid_attributes
      expect {
        delete :destroy, {:id => autocompletion.to_param}, valid_session
      }.to change(Autocompletion, :count).by(-1)
    end

    it "redirects to the autocompletions list" do
      autocompletion = Autocompletion.create! valid_attributes
      delete :destroy, {:id => autocompletion.to_param}, valid_session
      response.should redirect_to(autocompletions_url)
    end
  end

end
