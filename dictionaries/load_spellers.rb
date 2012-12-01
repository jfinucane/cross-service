
require File.expand_path('../read_dictionary.rb', __FILE__)
include ReadDictionary
require 'build_prefixes.rb'
include BuildPrefixes
require 'spell.rb'
include Spell

@sowpods, @popular, @sowpops = getter; nil

@pops = Hash.new
File.open('dictionaries/popular.txt','r') do |a|
  while(r=a.gets) do
    m = r.match(/(\w+)\s(\d+)/)
    popword  = m[1]
    smaller_score = (m[2].to_i**0.5).to_i
    @pops[m[1]] = smaller_score
  end
end

@popular_and_in_sowpods = @pops.each_key.select do |w| 
  (w.length > 2) && (@sowpods.include? w)
end 
=begin

good_scores = Scores.new 'sowpops_with_spellcheck', false
good_scores.reset
good_scores.build popular_and_in_sowpods.map{|word| [@pops[word], word]};nil
=end
@bad_scores = Scores.new 'sowpops_with_spellcheck'
puts 'start benchmark'
i=0
puts Benchmark.measure{
  @popular_and_in_sowpods[0,25000].each{|word|
    i +=1
    puts i if i%1000 == 0
    neighbors = Neighbors.new word
    errors = neighbors.edit1
    @bad_scores.build errors.map{|error| [@pops[word] || 1, word, error]}
  } 
}
=begin
a=File.open('bad_scores_21_final.txt', 'w')
buffer=[]
i=0
puts Benchmark.measure{
@bad_scores.auto.each{|s|i+=1;buffer << s; if i%10000==0; puts i; a.puts buffer.to_json; buffer=[]; end };nil
a.puts buffer.to_json
a.close
}
puts 'hi'
nil
=end