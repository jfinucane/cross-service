class Autocompletion < ActiveRecord::Base
  attr_accessible :dictionary_id, :prefix, :words
end
