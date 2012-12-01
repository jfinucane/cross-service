
task :load_levenhoods => :environment do 
  require './dictionaries/load_levenhood.rb'	
  puts 'Lets got for it on Heroku.'
  load_levenhood
end

task :load_wildcards => :environment do
  require './dictionaries/load_wildcard.rb'
  puts 'wildcards!!'
  load_wildcard
end

task :load_wildcards1 => :environment do
  require './dictionaries/load_wildcard1.rb'
  puts 'wildcards*'
  load_wildcard1
end

task :load_wildcards2 => :environment do
  require './dictionaries/load_wildcard2.rb'
  puts 'wildcards**'
  load_wildcard2
end


