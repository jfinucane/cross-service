require 'spec_helper'
describe LevenhoodsController do

  # This should return the minimal set of attributes required to create a valid
  # Levenhood. As you add validations to Levenhood, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    @neighbor = 'neighbor' + rand(999999).to_s
    @id =Dictionary.find_by_name('advancedtest').id   
     {dictionary_id: @id,  neighbor: @neighbor, words:['x'].to_json}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LevenhoodsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET show" do
    it "assigns the requested levenhood as @levenhood" do
      levenhood = Levenhood.create! valid_attributes
      get :show, {:id => @neighbor, dictionary: 'advancedtest'}, valid_session
      assigns(:levenhood).should eq(levenhood)
    end
  end
end
