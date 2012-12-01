require 'spec_helper'

describe "Levenhoods" do
  describe "GET /levenhoods" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get levenhoods_path
      puts response.inspect
      response.status.should be(200)
    end
  end
end
