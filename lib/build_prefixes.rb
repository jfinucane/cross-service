
module BuildPrefixes
  class Prefixes
    attr_accessor :auto, :id
    def initialize dict
      @auto = Hash.new{|h,k| h[k] = Set.new}
      raise unless @id = Dictionary.find_by_name(dict).id
    end

    def reset
      Autocompletion.where(dictionary_id: @id).each{|a| a.delete}
    end

    def build words, min_length=2
      words.each do |word|
        next if word.length < min_length
        (min_length..word.length).each do |i|
            prefix = word[0,i]
            current_count_for_prefix = @auto[prefix].size 
            next unless current_count_for_prefix < AUTOCOMPLETE
            @auto[prefix] += [word]
        end
      end
    end

    def persist
      @auto.each_pair do |k,v| 
        Autocompletion.create(prefix:k, words:v.to_json, dictionary_id: @id)
      end
    end
  end

  class Scores
    attr_accessor :auto, :id
    def initialize dict
      @auto = Hash.new{|h,k| h[k] = Array.new}
      raise unless @id = Dictionary.find_by_name(dict).id
    end
    def reset
      Autocompletion.where(dictionary_id: @id).each{|a| a.delete}
    end
    def reason_to_add_score score, prefix
      if @auto[prefix] == []
        true
      elsif @auto[prefix].map{|s| s[1]}.include?(score[1])
        false
      else
        has_room = @auto[prefix].size < AUTOCOMPLETE
        bigger_than_lowest = score[0] > @auto[prefix].first[0] 
        has_room || bigger_than_lowest
      end
    end
    def build scores, min_length=3, max_length=7
      scores.each do |score|
        word = score[2] || score[1]
        last= [max_length,word.length].min
        (min_length..last).each do |i|
          prefix = word[0,i]
          if reason_to_add_score score, prefix
            @auto[prefix] += [score]
            @auto[prefix].sort!
            @auto[prefix].shift if @auto[prefix].size > AUTOCOMPLETE
          end
        end
      end
    end

    def words prefix
      @auto[prefix].map{|score| score[1]}.reverse
    end

    def persist
      @auto.each_pair do |k,scores|
        v = scores.map{|score| score[1]}.reverse
        Autocompletion.create(prefix:k, words:v.to_json, dictionary_id: @id)
      end
    end
  end
end


