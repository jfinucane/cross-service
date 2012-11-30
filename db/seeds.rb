# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Dictionary.create(name: 'sowpods',
	              attribution: 'The official scrabble dictionary via Peter Norvig web site') unless Dictionary.where(:name=>'sowpods').count > 0;
Dictionary.create(name: 'popular',
	              attribution: 'google popular.txt via norvig') unless Dictionary.where(:name=>'popular').count > 0;
Dictionary.create(name: 'sowpops',
	              attribution: 'popular scrabble words: sowpows & popular') unless Dictionary.where(:name=>'sowpops').count > 0;
Dictionary.create(name: 'test', attribution: 'for testing') unless Dictionary.where(:name=>'test').count > 0;
Dictionary.create(name: 'advancedtest', attribution: 'for testing') unless Dictionary.where(:name=>'advancedtest').count > 0
Dictionary.create(name: 'advancedtest_with_spellcheck', attribution: 'add spelling errors to advanced test based on popular.txt scores') 
Dictionary.create(name: 'advancedtest_levenhood', attribution: 'build level levenshtein neighbors for advancedtest') 
Dictionary.create(name: 'sowpods_with_spellcheck', attribution: 'add spelling errors to sowpods based on popular.txt scores') 
Dictionary.create(name: 'sowpops_with_spellcheck', attribution: 'add spelling errors to sowpops based on popular.txt scores') 
Dictionary.create(name: 'sowpods_levenhood', attribution: 'build level levenshtein neighbors for sowpods') 
Dictionary.create(name: 'sowpops_levenhood', attribution: 'build level levenshtein neighbors for sowpops') 

