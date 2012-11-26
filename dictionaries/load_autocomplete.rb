

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
    smaller = (m[2].to_i**0.5).to_i
    @pops[m[1]] = smaller
  end
end

#pops are sorted in order of descending popularity
prefixes = Prefixes.new 'sowpops'
prefixes.reset
popular_and_in_sowpods = @pops.each_key.select{|w| 
  w.length > 1 && @sowpods.include? w
}
prefixes.build popular_and_in_sowpods

prefixes.persist

prefixes.change_dictionary 'sowpods'

@sowpods.each do |w|
  next unless w.length > 1
  prefixes.compute_each w
end

