rails new testgen -d postgresql
cd testgen
#change username in database.yml to jamesfinucane ($USER)

#modify gemfile for rspec-rails, capybara, factory_girl
rails generate rspec:install

rails generate scaffold Dictionaries name:text, attribution:text
rails generate scaffold Words word:text, dictionary_id:integer
rails generate scaffold Sketches gridtype:integer sketch:text 
rails generate scaffold Grids   gridtype:integer, orient:integer, nth:integer word_id:integer
rails generate scaffold GridTypes dictionary_id:integer, row_count:integer col_count:integer status:text
rails generate scaffold Anagrams dictionary_id:integer sorted_id:integer word_id:integer

rake db:create:all
rake db:migrate
rake db:seed

#add autocomplete
rails generate scaffold PopScores word:text score:integer dictionary_id:integer
rails generate scaffold Autocompletions prefix:text words:text dictionary_id:integer

rails generate scaffold Levenhoods neighbor:text words:text dictionary_id:integer
#modify the models for Autocompletions and Levenhoods
#add_index('autocompletions', 'prefix')
rails generate model Wildcards word:text words:text  dictionary_id:integer
