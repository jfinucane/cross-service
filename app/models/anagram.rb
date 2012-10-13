class Anagram < ActiveRecord::Base
  attr_accessible :sorted_id, :word_id
  has_many :words
end
