
module BuildPrefixes
  class Prefixes

    def initialize dict
      @auto = Hash.new{|h,k| h[k] = Set.new}
      raise unless @id = Dictionary.find_by_name(dict).id
    end

    def reset
      Autocompletion.where(dictionary_id: @id).each{|a| a.delete}
    end

    def build words
      words.each do |word|
        (1..word.length).each do |i|
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
end


