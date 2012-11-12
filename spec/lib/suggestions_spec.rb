require 'spec_helper.rb'
describe 'SingleDifference' do

  before :all do
    @host = 'anagrams.' + HOST + '/'
    @dict = 'advancedtest'
    word_list = ['dome', 'mode', 'demo', 'mod', 'mix', 'moody', 'model', 'mods',
                 'moronic', 'demos','me','my', 'mi', 'em' ]
    create_word @dict, word_list
    @addone_mod_result = {'e' =>['mode','demo','dome'], 's'=>['mods']}
    @addone_mode_result = {'l'=> ['model'], 's'=>['demos']}
    @shorten_mode_result = ['mod','me', 'em'].to_set
    @shorten_model_result = ['mode', 'demo', 'dome', 'mod','me', 'em'].to_set
    @mode_anagrams_result = ['demo', 'mode','dome']  
   end

  describe SingleDifference do 

    before :each do
      @dictionary = Dictionary.find_by_name(@dict)
      @s=SingleDifference.new @dictionary.id
    end

    it 'should create a dictionary' do
      id = @s.dictionary_id
      expect(@s.dictionary_id).to eq(@dictionary.id.to_s)
    end
    context '#addone' do 
      describe 'it should check for one letter added' do
        it {expect(@s.addone('mod')['s']).to eq(@addone_mod_result['s'])}
        it {expect(@s.addone('mod')['e']).to match_array(@addone_mod_result['e'])}
        it {expect(@s.addone('mode')['l']).to eq(@addone_mode_result['l'])}
        it {expect(@s.addone('mode')['s']).to eq(@addone_mode_result['s'])}
      end
    end
    context '#shorter' do
      describe 'it should check for shorter words' do
       it {expect(@s.shorten 'mode').to eq(@shorten_mode_result)}
       it {expect(@s.shorten 'model').to eq(@shorten_model_result)}
       it {expect(@s.shorten 'modle').to eq(@shorten_model_result)}
      end 
    end
    context '#anagrams' do
       it {expect(@s.anagrams 'mode').to match_array(@mode_anagrams_result)} 
    end
    context '#suggestions' do
       before :each do
         @results = @s.suggestions 'mode'
       end
       it {expect(@results['anagrams']).to match_array(@mode_anagrams_result)} 
       it {expect(@results['shorten']).to eq(@shorten_mode_result)}  
       it {expect(@results['addone']['e']).to eq(nil)} 
       it {expect(@results['addone']['l']).to eq(@addone_mode_result['l'])} 
       it {expect(@results['addone']['s']).to eq(@addone_mode_result['s'])} 
    end
    
  end
end