#not used
words.each_with_index{|w,i| 
  break if i>100
  sorted= sort_chars w.word
  sorted_id = Word.where(:word=>sorted, processed:1)
  key = 
  anagrams = REDIS.smembers("anag:1:#{sorted}")
  found = anagrams.include? w.word
  puts "#{w.word}, #{found}, #{anagrams.inspect}" unless found
}

def sort_chars word
	  word.each_char.map{|c|c}.sort.join('')    
  end
  
@words = Word.where(dictionary_id: 1, processed:0); nil
puts @words.count

def test
  puts Time.now
  singletons = 0
  multiples = 0
  @words.each_with_index{|w,i| 
    puts "#{w},#{i}, S: #{singletons}, M: #{multiples}, #{Time.now}" if i%1000 == 0
    sorted= sort_chars w.word
    sorted_id = Word.where(:word=>sorted, processed:1)
    key = "anag:1:#{sorted}"
    anagrams = REDIS.smembers key
    if anagrams.count == 1
      singletons += 1
      status = REDIS.del key
      puts "ERROR #{status} for #{key}" unless status == 'OK'
    else
      multiples += 1
    end
  }
  puts Time.now, singletons, multiples
end
test