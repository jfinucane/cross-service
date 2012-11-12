
require 'benchmark'
require 'curb'
require File.expand_path('../dictionaries/read_dictionary.rb', __FILE__)
include ReadDictionary
@sowpods, @popular, @sowpops = getter

def test
  i=0
  @sowpods.each{|w| 
    printf '.'
    puts Time.now if i%1000 == 0
    i+= 1
    word = Word.new({:word=>w,:processed=>0, :dictionary_id=>1})
    word.save
    sorted = Word.new({:word=>w.chars.sort.join(''),:processed=>1, :dictionary_id=>1})
    sorted.save
    Anagram.find_or_create_by_word_id_and_sorted_id(word.id, sorted.id)
  }
end

#test