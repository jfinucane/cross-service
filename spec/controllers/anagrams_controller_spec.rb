require 'spec_helper.rb'

describe AnagramsController do

  before :all do
    @host = 'anagrams.' + HOST + '/'
    @dict = 'test'
    word_list = 'tea', 'eat', 'ear', 'ate', 'rate','at'
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
      response.parsed.sort.should eq(['ate', 'eat', 'eta', 'tae', 'tea'])
    end
    it 'should not find anagrams for an unknown letter combination' do
      word='txn'
      response = Curl.get @host+ "#{word}.json?dictionary=test"
      response.parsed.count.should  == 0
    end
    it 'should find anagrams even if letters are out of order' do
      word='aet'
      response = Curl.get @host+ "#{word}.json?dictionary=test"
      response.parsed.count.should > 2
    end 
  end

  describe '#suggestions' do
    describe 'should make suggestions in addition to anagrams, ' do
      it 'should respond with a hash' do
        my_word = 'tea'
        response = Curl.get 'suggestions.' + HOST+ "/#{my_word}.json?dictionary=test"
        expect(get_keys response).to match_array(['addone', 'shorten', 'anagrams'])
      end
    end
  end

end



