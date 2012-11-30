class AdvancedTest < ActiveRecord::Migration
  def up
  	Dictionary.create(name: 'advancedtest_with_spellcheck', attribution: 'add spelling errors to advanced test based on popular.txt scores') 
    Dictionary.create(name: 'advancedtest_levenhood', attribution: 'build levenshtein neighbors for advancedtest')
  end

  def down
    
    Dictionary.where(name: 'advancedtest_with_spellcheck').each{|d|d.delete}
    Dictionary.where(name: 'advancedtest_levenhood').each{|d|d.delete}
  end
end
