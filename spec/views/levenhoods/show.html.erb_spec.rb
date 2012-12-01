require 'spec_helper'

describe "levenhoods/show" do
  before(:each) do
    @levenhood = assign(:levenhood, stub_model(Levenhood,
      :prefix => "MyText",
      :words => "MyText",
      :dictionary_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
