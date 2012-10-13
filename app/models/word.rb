class Word < ActiveRecord::Base
  attr_accessible :id, :dictionary_id, :word, :processed
  belongs_to :anagrams
end
