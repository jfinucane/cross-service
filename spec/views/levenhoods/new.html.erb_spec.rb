require 'spec_helper'

describe "levenhoods/new" do
  before(:each) do
    assign(:levenhood, stub_model(Levenhood,
      :prefix => "MyText",
      :words => "MyText",
      :dictionary_id => 1
    ).as_new_record)
  end

  it "renders new levenhood form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => levenhoods_path, :method => "post" do
      assert_select "textarea#levenhood_prefix", :name => "levenhood[prefix]"
      assert_select "textarea#levenhood_words", :name => "levenhood[words]"
      assert_select "input#levenhood_dictionary_id", :name => "levenhood[dictionary_id]"
    end
  end
end
