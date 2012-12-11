
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
  (w.length >= 3) && (@sowpods.include? w)
end 

@start = (REDIS.get 'wildcard3').to_i
@i = 0 
@dictionary=Dictionary.find_by_name('sowpops')
@log_file = File.open('./log/wildcard3', 'w')

def load_wildcard3
  puts "TRY TO LOAD WILDCARD3 from #{@start}"
  @popular_and_in_sowpods.each do |word|
    @i +=1
    next if @i <= @start
    (0...word.length-2).each{|first_char|
      (first_char+1...word.length-1).each{|second_char|
        (second_char+1...word.length).each{|third_char|
    	    temp = word.dup
          temp[third_char,1] = ''
          temp[second_char,1] =''
          temp[first_char,1] = ''
          Wildcards.create(temp+ '***', [word], @dictionary.id)
        }   
    	} 
    }
    REDIS.incr 'wildcard3'
    puts "#{@i}, #{word} was updated, #{Time.now}" if @i%1000 == 0
  end
end
