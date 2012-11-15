require 'spec_helper'

describe "autocompletions/index" do
  before(:each) do
    assign(:autocompletions, [
      stub_model(Autocompletion,
        :prefix => "MyText",
        :words => "MyText",
        :dictionary_id => 1
      ),
      stub_model(Autocompletion,
        :prefix => "MyText",
        :words => "MyText",
        :dictionary_id => 1
      )
    ])
  end

  it "renders a list of autocompletions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
    #assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
