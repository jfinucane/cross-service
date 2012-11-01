require 'spec_helper.rb'

describe AnagramsController do

  before :all do
    @host = 'anagrams.' + HOST + '/'

    @args = {:dictionary=>'test', :word=> 'tea'}
    Curl.post HOST+'/anagrams.json', @args
    @args = {:dictionary=>'test', :word=> 'eat'}
    Curl.post HOST+'/anagrams.json', @args
    @args = {:dictionary=>'test', :word=> 'ear'}
    Curl.post HOST+'/anagrams.json', @args
    @args = {:dictionary=>'test', :word=> 'ate'}
    Curl.post HOST+'/anagrams.json', @args
  end

  describe '#create' do
   
    before do 	
      @word = 'stuff' + rand(999999).to_s
      @args = {:dictionary=>'test', :word=> @word}
    end

    it 'should return JSON' do
    	@response = Curl.post HOST+'/anagrams.json', @args
      @response.status.should  match(/200/)
    	lambda{JSON.parse(@response.body_str)}.should_not raise_error
    end

    it 'should require a valid dictionary' do
    	@args[:dictionary] = 'junk'
    	response = Curl.post HOST+'/anagrams.json', @args
    	parsed = response.parsed
    	expect(parsed['status']).to eq 'provide a valid dictionary'
    end

    it 'should receive and return word as a param' do
      exp = Regexp.new(/#{@word}/)
      @response = Curl.post HOST+'/anagrams.json', @args
      parsed = JSON.parse(@response.body_str)
      expect(parsed['word']).to eq(@word)
      expect(response.body_str).to match(exp)
    end
  end

  describe '#show' do
  
    it 'should find anagrams' do
      word='tea'
      response = Curl.get @host + "#{word}.json?dictionary=test"
      response.parsed.should eq(['ate', 'eat', 'tea'])
    end
    it 'should not find anagrams for an unknown letter combination' do
      word='txn'
      response = Curl.get @host+ "#{word}.json?dictionary=test"
      response.parsed.should  eq([])
    end
    it 'should find anagrams even if letters are out of order' do
      word='tae'
      response = Curl.get @host+ "#{word}.json?dictionary=test"
      response.parsed.should eq(['ate', 'eat', 'tea'])
    end 
    it 'should default to sowpods, popular scrabble words' do
      #slightly evil and misleading; adding two bogus words in an official dictionary
      @args = {:dictionary=>'sowpods', :word=> 'testwordxxx'}
      Curl.post HOST+'/anagrams.json', @args
      @args = {:dictionary=>'sowpods', :word=> 'wordtestxxx'}
      Curl.post HOST+'/anagrams.json', @args
      response = Curl.get @host + 'xxxtestword.json'
      JSON.parse(response.body_str).sort.should eq(['testwordxxx', 'wordtestxxx'])
    end
  end

  describe '#showdb' do
    it 'should find anagrams' do
      word='tea'
      response = Curl.get HOST+ "/anagrams/showdb.json?word=#{word}&dictionary=test"
      response.parsed['words'].sort.should eq(['ate', 'eat', 'tea'])
    end

    it 'should find anagrams for a scrambled word' do
      my_word = 'encyclopedia'
      my_scrambled_word = my_word[2, my_word.size] + my_word[0,2]
      @args = {:dictionary=>'test', :word=> my_word}
      update =Curl.post HOST+'/anagrams.json', @args
      response = Curl.get HOST + "/anagrams/showdb.json?word=#{my_scrambled_word}&dictionary=test"
      response.parsed['words'].should eq([my_word])
    end
    it 'should not find anagrams for a fake word' do
      my_word = 'encyclopedia' + 'xxxx'
      response = Curl.get HOST + "/anagrams/showdb.json?word=#{my_word}&dictionary=test"
      response.parsed['words'].should be_nil
    end
  end

  describe '#suggestions' do
  end
end



