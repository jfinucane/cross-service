require 'spec_helper.rb'
require 'valid_dictionary.rb'
include ValidDictionary
describe WordsController do
  describe '#create' do
  	it 'should create a word' do 	
      @word = 'stuff' + rand(999999).to_s
      args = {:dictionary=>'test', :word=> @word}      
      response = Curl.post HOST+'/words.json', args
      response.body_str.should match(/success/)
    end
  end
  describe "#index" do
    before :all do
      @words = %w{aa ab ac ad ae af ag ah ai aj ak al}
      @words.each{ |w|
        Curl.post HOST + '/words.json',{:dictionary=>'test', :word=> w} 
      } 
    end
    
    it 'should get the test words' do
      response = Curl.get HOST + '/words.json' 
      words = get_array response
      found_words = @words.select{|w| words.include? w} 
      found_words.sort.should == @words
    end

    it 'should get a page size of three' do
      response = Curl.get HOST + '/words.json?page_size=3' 
      words = get_array response            
      words.should eq(['aa', 'ab', 'ac'])
    end

    it 'should get a second page size of three' do
      response = Curl.get HOST + '/words.json?page_size=3&start=3' 
      words = get_array response            
      words.should eq(['ad', 'ae', 'af'])
    end

    it 'should not fail when out of range' do
      response = Curl.get HOST + '/words.json?page_size=300&start=30000'
      words = get_array response
      words.should eq([])
    end
  end
end
