require 'sinatra'
require './environments'
require './actions/twitter'

require 'mongo'
require 'mongo_mapper'
require 'uri'
require 'json'
 
include Mongo

configure do

	conn = MongoClient.new('localhost')
	MongoMapper.connection = conn
	MongoMapper.database = 'kiss'
	require './models/tweets'
end

get '/' do
 	register(params)
end

post '/parse' do
	content_type :json
  register(params).to_json
  # register(params)
end

get '/test' do
	# tweet = Mentions.new(:created_at => Time.now, :text=>'testing', :name => 'gulnara')
	# tweet.save
	@tweets = Mentions.all
	erb :'tweet.html'
end

def register(params)
	@name = params[:name]
	puts "here is name for get #{@name}"
	@name ||= "kissmetrics"
 	@data = data(@name)
	erb :"home.html"
end

def data(name)
	puts "name of who we are searching for #{name}"
	client = TwitterGrapher::SearchHelper.create
	counts = client.count_tweets(@name)
	tweet_data = client.get_tweet_data(@name)
	tweet_data.each do |t|
		tweet = Mentions.new(:id => t["id"], :created_at => t["created_at"], :text=>t["text"], :name => t["name"], :user => @name)
		tweet.save
		puts tweet
	end
  d_3 = []
  counts.each { |key, value| d_3 << { "label" => key , "value"=> value } }
  @data = [{key: "Tweets for @#{name}", values: d_3}]


end

# def some(name)
# 	client = TwitterGrapher::SearchHelper.create

# end
	
