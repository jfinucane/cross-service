require 'spec_helper'

describe "autocompletions/edit" do
  before(:each) do
    @autocompletion = assign(:autocompletion, stub_model(Autocompletion,
      :prefix => "MyText",
      :words => "MyText",
      :dictionary_id => 1
    ))
  end

  it "renders the edit autocompletion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => autocompletions_path(@autocompletion), :method => "post" do
      assert_select "textarea#autocompletion_prefix", :name => "autocompletion[prefix]"
      assert_select "textarea#autocompletion_words", :name => "autocompletion[words]"
      assert_select "input#autocompletion_dictionary_id", :name => "autocompletion[dictionary_id]"
    end
  end
end
