require 'spec_helper.rb'
require 'yaml'
describe 'Autocomplete' do
  before :all do
    @host = 'autocomplete.' + HOST + '/'
    @dict = 'advancedtest'
    auto = "
auto:
  b: 
    bank: 30
    banks: 29
    barnes:    28
    best:      26
    belk:      24
  ba:
    banks:     dup
    barnes:    dup
    banana:   23
    bass:      22
    babies:    21
  ban:
    bank:      dup      
    banks:     dup
    banana:    dup
    bans:      20
  bant:  
    bant:      19
    bantu:     18
    banter:    17
    bantam:    16
  bante:
    bante:     15
    banter:    15
    bantering:  15
more:
  bastards: 21
  baskets: 21
  bassinets: 19
  baseball: 18
  brave: 27
  backup: 24
  bastes: 1 
  basted: 1
  bandanas: 1
"  
  
  @vocabulary = YAML::load(auto)
  puts @vocabulary
  AutocompletionsHelper::load_vocabulary @vocabulary, @dict
  @vocabulary['auto'].each {|prefix, scores|
    scores.each_pair{|word,score| 
    printf "%d,"%score.to_i
    #Popular.find_or_create(dictionary_id: @dict, word: word; score: score.to_i) unless score == 'dup'
    }
  } 
  end
  it 'should be ok' do
  end 
 




end