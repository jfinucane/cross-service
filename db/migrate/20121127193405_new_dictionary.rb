class NewDictionary < ActiveRecord::Migration
  def up
  	Dictionary.create(name: 'sowpods_with_spellcheck', attribution: 'add spelling errors to sowpods based on popular.txt scores') 
  	Dictionary.create(name: 'sowpops_with_spellcheck', attribution: 'add spelling errors to sowpops based on popular.txt scores') 
  end
  def down
  	Dictionary.where(name: 'sowpods_with_spellcheck').each{|d|d.delete}
  	Dictionary.where(name: 'sowpops_with_spellcheck').each{|d|d.delete}
  end
end
