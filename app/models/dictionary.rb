class Dictionary < ActiveRecord::Base
  attr_accessible :attribution, :name, :find_or_default
  
  def self.find_or_default params
 
	d = params[:dictionary]
    if d && dictionary = self.find_by_name(d.downcase) 
      default = false
    else dictionary = Dictionary.find_by_name('sowpods')
      default = true
    end
     return dictionary, default
  end
end
