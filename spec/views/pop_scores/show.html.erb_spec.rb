require 'spec_helper'

describe "pop_scores/show" do
  before(:each) do
    @pop_score = assign(:pop_score, stub_model(PopScore,
      :word => "MyText",
      :score => 1,
      :dictionary_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
