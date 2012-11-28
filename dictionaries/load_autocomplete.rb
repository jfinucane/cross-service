

require File.expand_path('../read_dictionary.rb', __FILE__)
include ReadDictionary
require 'build_prefixes.rb'
include BuildPrefixes

@sowpods, @popular, @sowpops = getter

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
  (w.length > 1) && (@sowpods.include? w)
end 

prefixes = Prefixes.new 'sowpops'
prefixes.reset
prefixes.build popular_and_in_sowpods
prefixes.persist

prefixes = Prefixes.new 'sowpods'
prefixes.reset
prefixes.build popular_and_in_sowpods
prefixes.build @sowpods
prefixes.persist


