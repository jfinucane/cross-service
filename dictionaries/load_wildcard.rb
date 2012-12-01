
require File.expand_path('../read_dictionary.rb', __FILE__)
include ReadDictionary
require 'build_prefixes.rb'
include BuildPrefixes
require 'spell.rb'
include Spell
puts 'loading dictionaries'
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
  (w.length > 1) && (@sowpods.include? w)
end 

@start = (REDIS.get 'wildcard').to_i
@i = 0 
@dictionary=Dictionary.find_by_name('sowpops')
@log_file = File.open('./log/tempw', 'w')

def valid_words words 
  words.select{|w| 
    @popular_and_in_sowpods.include? w}
end

def load_wildcard
  @popular_and_in_sowpods.each do |word|
    error_msg = ''
    @i +=1
    next if @i < @start
    puts "#{@i}, #{Time.now}" if @i%10000 == 0
    Wildcards.create(word, [word], @dictionary.id)
  end
end