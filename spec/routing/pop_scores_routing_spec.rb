require "spec_helper"

describe PopScoresController do
  describe "routing" do

    it "routes to #index" do
      get("/pop_scores").should route_to("pop_scores#index")
    end

    it "routes to #new" do
      get("/pop_scores/new").should route_to("pop_scores#new")
    end

    it "routes to #show" do
      get("/pop_scores/1").should route_to("pop_scores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pop_scores/1/edit").should route_to("pop_scores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pop_scores").should route_to("pop_scores#create")
    end

    it "routes to #update" do
      put("/pop_scores/1").should route_to("pop_scores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pop_scores/1").should route_to("pop_scores#destroy", :id => "1")
    end

  end
end
