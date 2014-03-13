require 'sinatra'
require './environments'
require './actions/twitter'
require 'json'
 

def register(params)
	@name = params[:name]
	puts "here is name for get #{@name}"
	@name ||= "kissmetrics"
 	@data = data(@name)
	erb :"home.html"
end

get '/' do
 	register(params)
end

post '/parse' do
	content_type :json
  register(params).to_json
  # register(params)
end

def data(name)
	puts "name of who we are searching for #{name}"
	client = TwitterGrapher::SearchHelper.create
	counts = client.count_tweets(@name)
  d_3 = []
  counts.each { |key, value| d_3 << { "label" => key , "value"=> value } }
  @data = [{key: "Tweets for @#{name}", values: d_3}]
end
