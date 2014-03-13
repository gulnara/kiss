require 'sinatra'
require './environments'
require './actions/twitter'
require 'json'
 

def register(params)
	puts "here is name for post #{params[:name]}"
end

get '/' do
	@name = params[:name]
	puts "here is name for get #{@name}"
	@name ||= "kissmetrics"
 	@data = data(@name)
	erb :"home.html"
end

post '/parse' do
	register(params)
end

def data(name)
	puts "name of who we are searching for #{name}"
	client = TwitterGrapher::SearchHelper.create
	counts = client.count_tweets(@name)
  d_3 = []
  counts.each { |key, value| d_3 << { "label" => key , "value"=> value } }
  @data = [{key: "Tweets for @#{name}", values: d_3}]
end
