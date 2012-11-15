require "spec_helper"

describe AutocompletionsController do
  describe "routing" do

    it "routes to #index" do
      get("/autocompletions").should route_to("autocompletions#index")
    end

    it "routes to #new" do
      get("/autocompletions/new").should route_to("autocompletions#new")
    end

    it "routes to #show" do
      get("/autocompletions/1").should route_to("autocompletions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/autocompletions/1/edit").should route_to("autocompletions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/autocompletions").should route_to("autocompletions#create")
    end

    it "routes to #update" do
      put("/autocompletions/1").should route_to("autocompletions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/autocompletions/1").should route_to("autocompletions#destroy", :id => "1")
    end

  end
end
