module Autoload
  require 'build_prefixes.rb'
  include BuildPrefixes
	require 'yaml'

  class Autoloader

    def complete prefix
  	  @vocabulary['auto'][prefix].map{|pair| pair[0]}
    end

  	def initialize
 
      @vocabulary = YAML::load(vocabulary_yml)
      prefixes = Prefixes.new 'advancedtest'
  	  prefixes.reset
      
      test_scores = SortedSet.new

  	  @vocabulary['auto'].each{|prefix, scores|
	      scores.each_pair{|word,score|
	      	next if score=='dup'
	      	test_scores += [[score,word]] 
	      }
      }
      @vocabulary['more'].each_pair{|word,score|
        test_scores += [[score,word]]
      }

      words = test_scores.map{|s| s[1]}
      prefixes.build words.reverse

      prefixes.persist
  	end

    def vocabulary_yml
"
auto:
  b: 
    bank: 30
    banks: 29
    barnes:    28
    best:      26
    belk:      25
  ba:
    bank: dup
    banks:     dup
    barnes:    dup
    banana:   24
    bass:      23
  ban:
    bank:      dup      
    banks:     dup
    banana:    dup
    bans:      21
    ban:       20
  bant:  
    bant:      19
    bantu:     18
    banter:    17
    bantam:    16
    bantering: 15
  bante:
    bante:     15
    banter:    15
    bantering:  dup
  bas: 
    bass:  dup
    bastards: 21
    baskets: 21    
more:
  bassinets: 19
  baseball: 18
  brave: 17
  backup: 14
  bastes: 1 
  basted: 1
  bandanas: 1
"  
    end
  end
end

