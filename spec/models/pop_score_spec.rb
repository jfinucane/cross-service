require 'spec_helper'

describe PopScore do
  

  before :all do 
  	@dict='advancedtest'
    raise unless @id= Dictionary.find_by_name(@dict).id
    scores = PopScore.where(:dictionary_id => @id)
    scores.each{|s| s.delete}
  end
  describe '#create' do
  	before :all do
  	  @word = 'aardvark'
  	  p = PopScore.create(word: @word, score: 40, dictionary_id: @id)
      @q = PopScore.where(word: @word, dictionary_id: @id)
    end
    it  'there will be one score for a word' do
      expect(@q.count).to eql(1)
    end
    it 'will update if word exists' do
      p = PopScore.create(word: @word, score: 60, dictionary_id: @id)
      @q = PopScore.where(word: @word, dictionary_id: @id)
      expect(@q.count).to eql(1)
      expect(@q.first.score).to eql(60)
    end
  end
  describe '#reset' do
    it 'should reset the scores database' do
      p = PopScore.create(word: 'abc', score: 40, dictionary_id: @id)
      p = PopScore.create(word: 'xyz', score: 40, dictionary_id: @id)
      q = PopScore.where(dictionary_id: @id)
      q.count.should > 1
      PopScore.new.reset @id
      q = PopScore.where(dictionary_id: @id)
      expect(q.count).to eql(0)
    end
  end
end