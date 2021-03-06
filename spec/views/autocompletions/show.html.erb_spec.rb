require 'spec_helper'

describe "autocompletions/show" do
  before(:each) do
    @autocompletion = assign(:autocompletion, stub_model(Autocompletion,
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
