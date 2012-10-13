# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Dictionary.create(name: 'sowpods',
	              attribution: 'scrabble via norvig');
Dictionary.create(name: 'popular',
	              attribution: 'google popular.txt via norvig');
Dictionary.create(name: 'sowpops',
	              attribution: 'popular scrabble words: sowpows & popular');