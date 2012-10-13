require 'spec_helper.rb'
require 'get_words.rb'
include GetWords
describe AnagramsController do

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
    it 'should require a dictionary'  do
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
    it 'should default to sowpops, popular scrabble words' do
      @args = {:dictionary=>'sowpops', :word=> 'testword'}
      Curl.post HOST+'/anagrams.json', @args
      @args = {:dictionary=>'sowpops', :word=> 'wordtest'}
      Curl.post HOST+'/anagrams.json', @args
      response = Curl.get HOST + '/anagrams/testword.json'
      JSON.parse(response.body_str).sort.should eq(['testword', 'wordtest'])
    end
  end
end



