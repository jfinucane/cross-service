
require File.expand_path('../dictionaries/read_dictionary.rb', __FILE__)
include ReadDictionary
require 'build_prefixes.rb'
include BuildPrefixes
require 'spell.rb'
include Spell
puts Neighbors.new 'fred'

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

popular_and_in_sowpods = @pops.each_key.select do |w| 
  (w.length > 2) && (@sowpods.include? w)
end 
=begin
scores = Scores.new 'sowpops_with_spellcheck'
scores.reset
scores.build popular_and_in_sowpods.map{|word| [@pops[word], word]}
@sowpops.to_a[0,100].each{|word|
  neighbors = Neighbors.new word
  errors = neighbors.edit1
  scores.build errors.map{|error| [@pops[error], error]}
}
#scores.persist
=end
good_scores = Scores.new 'sowpops_with_spellcheck'
good_scores.reset
good_scores.build popular_and_in_sowpods.map{|word| [@pops[word], word]};nil
#@sowpops.to_a[0,100].each{|word|
#@sowpops.to_a[0,10000].each{|word|
bad_scores = Scores.new 'sowpops_with_spellcheck'
puts 'start benchmark'
puts Benchmark.measure{
  popular_and_in_sowpods[0,30000].each{|word|
    neighbors = Neighbors.new word
    errors = neighbors.edit1
    bad_scores.build errors.map{|error| [@pops[word] || 1, word, error]}
  } 
}
scores.auto['aba']
scores.auto['abx']
scores.auto['ret']

scores.auto['ewn']
puts 'hi'
nil
