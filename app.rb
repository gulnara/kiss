require 'sinatra'
require './environments'
require './actions/twitter'


get '/' do

		erb :"home.html"

end


post '/' do
		client = TwitterGrapher::SearchHelper.create
		@name = params[:name]
		@counts = client.count_tweets(@name)
		erb :"home.html"
end