require 'sinatra'
require './environments'
require './actions/twitter'
require 'mongo'
require 'mongo_mapper'
require 'uri'
require 'json'

include Mongo

# configure do
# 	conn = MongoClient.new('localhost')
# 	MongoMapper.connection = conn
# 	MongoMapper.database = 'tweets'
# 	require './models/tweet'
# end

mongo_url = ENV['MONGOHQ_URL'] || 'mongodb://localhost/dbname'
 
MongoMapper.connection = Mongo::Connection.from_uri mongo_url
MongoMapper.database = URI.parse(mongo_url).path.gsub(/^\//, '') #Extracts 'dbname' from the uri
require './models/tweet'


get '/users' do
	users = Mention.all
	@users = users.map{|a| a.user}.uniq.sort
	erb :'users'
end
 
get '/users=:name' do
	@name = params[:name]
	tweets = Mention.all
	unsorted_tweets = tweets.select{|a| a.user==@name}
	@sorted_tweets = unsorted_tweets.sort_by{|a| a['created_at']}.reverse!
	erb :'tweets'
end

get '/tweets=:name' do
	@name = params[:name]
 	@data2 = tweets(@name)
	erb :"test"
end


def register(params)
	@name = params[:name]
	@name ||= "gulnara"
 	@data = data(@name)
	erb :"home"
end


get '/' do
 	register(params)
end

post '/parse' do
	content_type :json
  register(params).to_json
end

def data(name)
	client = TwitterGrapher::SearchHelper.create
	counts = client.count_tweets(@name)
	tweet_data = client.get_tweet_data(@name)
	tweet_data.each do |t|
		tweet = Mention.new(:tweet_id => t["tweet_id"], :user => t["user"], :created_at => t["created_at"], :text=>t["text"], :name => t["name"])
		tweet.save
	end
  d_3 = []
  counts.each { |key, value| d_3 << { "label" => key , "value"=> value } }
  @data = [{key: "Tweets for @#{name}", values: d_3}]
end


def tweets(name)
	client = TwitterGrapher::SearchHelper.create
	counts2 = client.get_tweets(@name)
	#this is for d3js data
  dv2_3 = []
  counts2.each { |key, value| dv2_3 << { "label" => key , "value"=> value } }
  data = [{key: "Tweets for @#{name}", values: dv2_3}]
end
