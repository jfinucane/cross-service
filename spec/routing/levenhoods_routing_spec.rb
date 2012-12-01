require "spec_helper"

describe LevenhoodsController do
  describe "routing" do

    it "routes to #index" do
      get("/levenhoods").should route_to("levenhoods#index")
    end

    it "routes to #new" do
      get("/levenhoods/new").should route_to("levenhoods#new")
    end

    it "routes to #show" do
      get("/levenhoods/1").should route_to("levenhoods#show", :id => "1")
    end

    it "routes to #edit" do
      get("/levenhoods/1/edit").should route_to("levenhoods#edit", :id => "1")
    end

    it "routes to #create" do
      post("/levenhoods").should route_to("levenhoods#create")
    end

    it "routes to #update" do
      put("/levenhoods/1").should route_to("levenhoods#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/levenhoods/1").should route_to("levenhoods#destroy", :id => "1")
    end

  end
end
