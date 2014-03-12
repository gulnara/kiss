require 'sinatra'
require './environments'
require './actions/twitter'


get '/' do
	@counts = count_tweets
	erb :"home.html"

end
