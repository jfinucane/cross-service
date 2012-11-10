require 'spec_helper.rb'
describe Edit1 do
  before :all do
    @s = Edit1.new 'word'
  end	
  describe "#new" do
    it 'should create splits' do
      @s.splits.should match_array([
      	['','word'], ['w','ord'],['wo','rd'],['wor','d'],['word','']
      	])
    end
  end
  describe "#deletes" do
    it 'should delete chars' do
      @s.deletes.should match_array(['ord', 'wrd', 'wod', 'wor'])
    end
  end
  describe "#transposes" do
    it "should transpose chars" do
      @s.transposes.should match_array(['owrd', 'wrod', 'wodr'])
    end
  end
  describe "#replaces" do
  	before :all do
      @replacements = @s.replaces
    end
    it 'the count should be 104'  do @replacements.count.should eq(104); end
    it 'ward is included'  do @replacements.include?('ward').should be_true; end
    it 'worz is included'  do @replacements.include?('worz').should be_true; end
    it 'warz is not included'  do @replacements.include?('warz').should be_false; end
  end
  describe "#inserts" do
    before :all do
      @inserts = @s.inserts
    end
    it 'the count should be 130' do @inserts.count.should eq(130); end
    it 'aword is included' do @inserts.include?('aword').should be_true; end
    it 'wozrd is included' do @inserts.include?('wozrd').should be_true; end
    it 'award is not included' do @inserts.include?('award').should be_false; end
  end
  describe "#words" do
    before :all do
      @neighborhood = @s.edit1
      @words_with_dups = @s.words_with_dups
    end
    it 'the count should be 241' do @words_with_dups.count.should eq(241); end
    it 'without dups should be a bit less than 241' do
      @neighborhood.count.should < 241
    end
  end
end

