class PopScore < ActiveRecord::Base
  attr_accessible :dictionary_id, :score, :word
  def self.create params
    t = self.find_by_dictionary_id_and_word(params[:dictionary_id], params[:word])
    if t
      t.update_attributes(score: params[:score])
    else
      p = self.new(params)
      result = p.save
    end
  end
  def reset dictionary_id
  	scores = PopScore.where(:dictionary_id => dictionary_id)
  	scores.each{|s|s.delete}
  end
end
