module ReadDictionary
require 'set'
	def getter
	  
	  file = File.expand_path('../sowpods.txt', __FILE__)
		f=File.open(file,'r')
    
		@words=Set.new
		while(w=f.gets) 
		  @words << w.strip.downcase
		end
		f.close

		#p=File.open('../dictionaries/popular.txt','r')
    file = File.expand_path('../popular.txt', __FILE__)
		p=File.open(file,'r')

		@pwords=Set.new
		while(w=p.gets) 
		  @pwords << w.strip.split("\t")[0]
		end
		p.close

		@sowpops= @pwords & @words
		 
		puts "#{@words.count}, #{@pwords.count},#{@sowpops.count}"
		return @words, @pwords, @sowpops
	end
end