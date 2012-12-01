require 'spec_helper'

describe "levenhoods/index" do
  before(:each) do
    assign(:levenhoods, [
      stub_model(Levenhood,
        :prefix => "MyText",
        :words => "MyText",
        :dictionary_id => 1
      ),
      stub_model(Levenhood,
        :prefix => "MyText",
        :words => "MyText",
        :dictionary_id => 1
      )
    ])
  end

  it "renders a list of levenhoods" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
