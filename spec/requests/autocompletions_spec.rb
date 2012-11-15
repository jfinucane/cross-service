require 'spec_helper'

describe "Autocompletions" do
  describe "GET /autocompletions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get autocompletions_path
      response.status.should be(200)
    end
  end
end
