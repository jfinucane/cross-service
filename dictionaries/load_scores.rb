require 'json'
require File.expand_path('../read_dictionary.rb', __FILE__)
include ReadDictionary

   @sowpods, @popular, @sowpops = getter
def load_scores
   @pops = Hash.new
   a=File.open('dictionaries/popular.txt','r')
   i=0
   while(r=a.gets) do
     m = r.match(/(\w+)\s(\d+)/)
     popword  = m[1]
     smaller = (m[2].to_i**0.5).to_i
     @pops[popword] = smaller
   end
   a.close
   puts @pops.count

  puts dictionary='popular'
  dictionary_id = Dictionary.find_by_name(dictionary).id  
  raise unless dictionary_id
  @pops.each_pair{|k,v|
    PopScore.create(word: k, score: v, dictionary_id: dictionary_id)
  }
  puts PopScore.where(dictionary_id: dictionary_id).count
 
# popular words that are legal scrabble words
  puts dictionary='sowpops'
  dictionary_id = Dictionary.find_by_name(dictionary).id  
  raise unless dictionary_id
  @pops.each_pair{|k,v|
    @sowpods[k] && PopScore.create(word: k, score: v, dictionary_id: dictionary_id) 
  }
  puts PopScore.where(dictionary_id: dictionary_id).count

# default score 10 when not in popular.txt
  puts dictionary='sowpods'
  dictionary_id = Dictionary.find_by_name(dictionary).id  
  raise unless dictionary_id
  @sowpods.each{|w|
    PopScore.create(word: w, score: @pops[w] || 10, dictionary_id: dictionary_id) 
  }
  puts PopScore.where(dictionary_id: dictionary_id).count
end
Benchmark.measure{load_scores}