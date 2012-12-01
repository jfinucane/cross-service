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
  (w.length > 2) && (@sowpods.include? w)
end 

puts 'start benchmark'
@start = (REDIS.get 'levenhood').to_i
@i = 0 
@dictionary=Dictionary.find_by_name('sowpops')
@log_file = File.open('./log/temp', 'w')
raise 'Check the Dictionary name' unless @dictionary
def load_levenhood

  @log_file.puts Benchmark.measure{
    @popular_and_in_sowpods.each{|word|
      puts "#{word}"
      error_msg = ''
      @i +=1
      next if @i < @start
      @log_file.puts @i if @i%100 == 0
      neighbors = Neighbors.new word
      levenhood = neighbors.levenhood
      levenhood.each{|neighbor|  
        auto = Levenhood.find_by_neighbor_and_dictionary_id(neighbor, @dictionary.id)
        if auto 
          w = JSON.parse(auto.words)
          w << word unless w.include? word
          auto.words = w.to_json
          begin
            auto.save
          rescue
            error_msg = 'failed to save'
          end
        else
          w = [word].to_json
          begin
            Levenhood.create(dictionary_id: @dictionary.id,
            words: w,
            neighbor: neighbor)
          rescue
            error_msg = 'failed to create'
          end
        end
      }

      @log_file.puts "Done with #{word}, #{@i}, #{@start}, #{error_msg}"
      REDIS.incr 'levenhood'
    } 
	}	
  @log_file.close
end