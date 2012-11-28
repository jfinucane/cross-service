require 'spec_helper.rb'

describe Prefixes do

  after :all do
    AUTOCOMPLETE = 5
  end

  context '#initialize' do
    it 'looks up the dictionary id' do
    	d = Prefixes.new 'advancedtest'
    	d.id.should_not be_nil
    	d.auto['random'].class.should == Set
    end

    it 'needs a valid dictionary' do
      expect{Prefixes.new 'baloney dictionary'}.to raise_error
    end
  end

  context '#reset' do
    it 'resets the dictionary' do
    	d = Prefixes.new 'advancedtest' 
    	d.reset
    	Autocompletion.where(:dictionary_id=>@id).should == []	
    end
  end

  context '#build' do
    before do
      @d = Prefixes.new 'advancedtest'
      @word_list = ['deal','den']
      @d.build @word_list
    end
    it 'should build prefixes for de' do
      @d.auto['de'].to_a.should match_array(@word_list)  
    end
    it 'should build prefixes for den'  do
      @d.auto['den'].to_a.should match_array(['den'])  
    end
    it 'should provide an empty array if no match'  do
      @d.auto['dented'].to_a.should match_array([])  
    end
  end

end

describe Scores do
  context '#build' do
    context 'scores determine order' do 
      before :each do
        @d = Scores.new 'advancedtest'
        @word_list = [[10, 'deal'],[5,'deacon']]
        @d.build @word_list
      end
      it 'should build prefixes for dea' do
        @d.words('dea').to_a.should match_array(['deal', 'deacon'])  
      end
      it 'should build prefixes for dea by score'  do
        AUTOCOMPLETE = 5
        @d.build [[7,'dearest']] 
        @d.words('dea').to_a.should == ['deal','dearest','deacon']  
      end
      it 'should bump the low score when limited'  do
        AUTOCOMPLETE =2
        @d.build [[7,'dearest']]
        @d.words('dea').to_a.should ==['deal','dearest']  
      end
      it 'should ignore the low score when limited'  do
        AUTOCOMPLETE =2
        @d.build [[2,'dearest']]
        @d.words('dea').to_a.should match_array(['deal','deacon'])  
      end
      it 'should provide an empty array if no match'  do
        @d.words('dented').to_a.should match_array([])  
      end
      it 'should not add duplicates' do
        @d.build [[10,'deal']]
        @d.words('dea').to_a.should == ['deal','deacon']
      end
    end
    context 'control the length of prefixes'  do    
      before :each do
        @d = Scores.new 'advancedtest'
      end
      it 'should only create the specified prefixes' do
        @d.build [[17, 'beastly']], min_length=2,max_length=4
        @d.auto.keys.should match_array(['be', 'bea', 'beas'])
      end
      it 'should only create the specified prefixes' do
        @d.build [[17, 'beastlinesses']], min_length=1,max_length=20
        @d.auto.keys.count.should == 13
      end
      it 'should not raise when words are short' do
        @d.build [[17, 'at']], min_length=3
        @d.auto.keys.count.should == 0
      end
    end
  end
end