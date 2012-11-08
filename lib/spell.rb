module Spell
	class Edit1
	  attr_accessor :word, :splits, :edit2_words
    def initialize word
    	@word = word
    	@splits = (0..@word.length).each.map{|s|[@word[0, s],@word[s..-1]]}
    end
    def deletes
      return [] if @word.length < 3
      #@splits.map{|split| split[1] == '' ? split[0] + split[1][1..-1] : nil}.compact
      (0...@word.length).map{|position| 
        left, right = @splits[position] 
        left + right[1..-1]}
    end
    def transposes
      return [] if @word.length < 2
      (0..@word.length-2).map{|position|
        left, right = @splits[position] 
        left + right[1,1] + right[0,1] + right[2..-1]
      }
    end
    def replaces
      return [] if @word.length < 2
      (0...@word.length).inject([]) do |a,position| 
        left, right = @splits[position] 
        ('a'..'z').inject(a){|b,char| b << left + char + right[1..-1]}
      end 
    end
    def inserts
      return [] if @word.length < 1
      (0..@word.length).inject([]) do |a,position| 
        left, right = @splits[position] 
        ('a'..'z').inject(a){|b,char| b << left + char + right}
      end 
    end
    def edit1
      (deletes + transposes + replaces + inserts).to_set
    end

    def edit2
      @edit2_words=Set.new
      edit1.each{|word| @edit2_words += Edit1.new(word).edit1}
      puts @edit2.count
    end

  end
end  