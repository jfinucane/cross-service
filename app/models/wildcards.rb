class Wildcards < ActiveRecord::Base
  attr_accessible :dictionary_id, :word, :words

  def self.create word, words, dictionary_id
    sorted_word = word.chars.sort.join('')
    t = self.find_by_dictionary_id_and_word(dictionary_id, sorted_word)
    if t
      w = JSON.parse(t.words)
      w += words
      t.update_attributes(words: Set.new(w).to_json)
      t.save
    else
      w = Wildcards.new(word: sorted_word,
        words: words.to_json, 
        dictionary_id: dictionary_id)
      w.save
    end
  end
end
