require 'spec_helper.rb'
require 'get_words.rb'
include GetWords
describe AnagramsController do

  before :all do
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
      parsed = JSON.parse(@response.body_str)
      response.status.should  match(/200/)
    	lambda{parsed}.should_not raise_error
    end

    it 'should require a valid dictionary' do
    	@args[:dictionary] = 'junk'
    	@response = Curl.post HOST+'/anagrams.json', @args
    	parsed = JSON.parse(@response.body_str)
    	expect(parsed['status']).to eq 'bad dictionary parameter'
    end

    it 'should receive and return word as a param' do
      exp = Regexp.new(/#{@word}/)
      @response = Curl.post HOST+'/anagrams.json', @args
      parsed = JSON.parse(@response.body_str)
      expect(parsed['word']).to eq(@word)
      expect(response.body_str).to match(exp)
    end
  end

  describe '#index' do
  
    it 'should require a dictionary'  do
      pending 'sowpods is the defaults dictionary'
      response = Curl.get HOST+ '/anagrams.json?word=ate'
      response.body_str.should match(/missing dictionary/)  
    end
    it 'should require a valid dictionary' do
      response = Curl.get HOST+ '/anagrams.json?word=ate&dictionary=bozo'
      response.body_str.should match(/bad dictionary/)
    end
    it 'should find anagrams' do
      word='tea'
      response = Curl.get HOST+ "/anagrams.json?dictionary=test&word=#{word}"
      response.body_str.should match(/success/)
      (get_words response).should eq(['ate', 'eat', 'tea'])
    end
    it 'should not find anagrams for an unknown letter combination' do
      word='txn'
      response = Curl.get HOST+ "/anagrams.json?dictionary=test&word=#{word}"
      response.body_str.should match(/no anagrams/)
    end
    it 'should find anagrams even if letters are out of order' do
      word='tae'
      response = Curl.get HOST+ "/anagrams.json?dictionary=test&word=#{word}"
      response.body_str.should match(/success/)
      (get_words response).should eq(['ate', 'eat', 'tea'])
    end 
  end

  describe '#show' do
    it 'should find anagrams' do
      word='tea'
      response = Curl.get HOST+ "/anagrams/#{word}.json?dictionary=test"
      JSON.parse(response.body_str).should eq(['ate', 'eat', 'tea'])
    end
    it 'should default to sowpods, popular scrabble words' do
      #slightly evil and misleading; adding two bogus words in an official dictionary
      @args = {:dictionary=>'sowpods', :word=> 'testwordxxx'}
      Curl.post HOST+'/anagrams.json', @args
      @args = {:dictionary=>'sowpods', :word=> 'wordtestxxx'}
      Curl.post HOST+'/anagrams.json', @args
      response = Curl.get HOST + '/anagrams/xxxtestword.json'
      JSON.parse(response.body_str).sort.should eq(['testwordxxx', 'wordtestxxx'])
    end
    it 'should find anagrams for a scrambled word' do
      my_word = 'encyclopedia'
      my_scrambled_word = my_word[2, my_word.size] + my_word[0,2]
      @args = {:dictionary=>'test', :word=> my_word}
      Curl.post HOST+'/anagrams.json', @args
      response = Curl.get HOST + "/anagrams/#{my_scrambled_word}.json?dictionary=test"
      JSON.parse(response.body_str).sort.should eq([my_word])
    end
    it 'should not find anagrams for a fake word' do
      my_word = 'encyclopedia' + 'xxxx'
      response = Curl.get HOST + "/anagrams/#{my_word}.json?dictionary=test"
      JSON.parse(response.body_str).sort.should eq([])
    end
  end

  describe '#suggestions' do
  end
end



