require 'spec_helper'

describe "pop_scores/edit" do
  before(:each) do
    @pop_score = assign(:pop_score, stub_model(PopScore,
      :word => "MyText",
      :score => 1,
      :dictionary_id => 1
    ))
  end

  it "renders the edit pop_score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pop_scores_path(@pop_score), :method => "post" do
      assert_select "textarea#pop_score_word", :name => "pop_score[word]"
      assert_select "input#pop_score_score", :name => "pop_score[score]"
      assert_select "input#pop_score_dictionary_id", :name => "pop_score[dictionary_id]"
    end
  end
end
