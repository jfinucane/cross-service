module Spell
	class Neighbors
	  attr_accessor :word, :splits, :edit2_words, :words_with_dups
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
      list = (0...@word.length).inject([]) do |a,position| 
        left, right = @splits[position] 
        ('a'..'z').inject(a){|b,char| b << left + char + right[1..-1]}
      end 
      list.delete(@word)
      list
    end
    def inserts
      return [] if @word.length < 1
      (0..@word.length).inject([]) do |a,position| 
        left, right = @splits[position] 
        ('a'..'z').inject(a){|b,char| b << left + char + right}
      end 
    end
    def edit1
      @words_with_dups = deletes + transposes + replaces + inserts
      @words_with_dups.to_set
    end

    def levenhood
      @words_with_dups = deletes + replaces + inserts
      @words_with_dups.to_set
    end

    def edit2
      @edit2_words=Set.new
      edit1.each{|word| @edit2_words += Neighbors.new(word).edit1}
      puts @edit2.count
    end

  end
end  