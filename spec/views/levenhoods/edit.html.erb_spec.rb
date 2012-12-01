require 'spec_helper'

describe "levenhoods/edit" do
  before(:each) do
    @levenhood = assign(:levenhood, stub_model(Levenhood,
      :prefix => "MyText",
      :words => "MyText",
      :dictionary_id => 1
    ))
  end

  it "renders the edit levenhood form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => levenhoods_path(@levenhood), :method => "post" do
      assert_select "textarea#levenhood_prefix", :name => "levenhood[prefix]"
      assert_select "textarea#levenhood_words", :name => "levenhood[words]"
      assert_select "input#levenhood_dictionary_id", :name => "levenhood[dictionary_id]"
    end
  end
end
