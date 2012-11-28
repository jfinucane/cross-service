class AddLevenhood < ActiveRecord::Migration
  def up
  	Dictionary.create(name: 'sowpods_levenhood', attribution: 'build level levenshtein neighbors for sowpods') 
  	Dictionary.create(name: 'sowpops_levenhood', attribution: 'build level levenshtein neighbors for sowpops') 
  end
  def down
  	Dictionary.where(name: 'sowpods_levenhood').each{|d|d.delete}
  	Dictionary.where(name: 'sowpops_levenhood').each{|d|d.delete}
  end
end
