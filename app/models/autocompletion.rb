class Autocompletion < ActiveRecord::Base
  attr_accessible :dictionary_id, :prefix, :words
  def self.create_in_dictionary auto, dictionary_id
  	auto[:dictionary_id] = dictionary_id
  	existing = Autocompletion.find_by_prefix_and_dictionary_id(auto[:prefix], dictionary_id)
  	if existing
  	  existing.update_attributes(auto)
    else
  	  existing = Autocompletion.create(auto) 
  	end
  	existing
  end
end
