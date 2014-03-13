require 'sinatra'
require './environments'
require './actions/twitter'
require 'json'
 
get '/' do
	@name ||= "kissmetrics"
 	@data = data(@name)
	erb :"home.html"
end

def register(params)
	@name = params[1]
end

post '/parse' do
	register(params)
end

get '/parse' do
	erb :"home.html"
end

def data(name)
	client = TwitterGrapher::SearchHelper.create
	counts = client.count_tweets(@name)
  d_3 = []
  counts.each { |key, value| d_3 << { "label" => key , "value"=> value } }
  @data = [{key: "Tweets for @#{@name}", values: d_3}]
end
