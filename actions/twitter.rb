require 'twitter'
require 'json'

def starting_client

	client = Twitter::REST::Client.new do |config|
		config.consumer_key    = "jzWC3q7DjOhbPnXTLNfiiA"
		config.consumer_secret = "zbkSHI2Oufq0V4B1WtQwjucXVmEAbWwjwBvSKSPIzg"
		config.access_token        = "369737491-kh0ruoo7yWlr2VYc5u1EZRZqCJqmKi3RqbL2Zwwk"
		config.access_token_secret = "pcpw87tSAeVu8JQpNftoLA4E3raaSIGbSUeG4EewwvKrA"
	end

	return client

end

#for some reason can't get tweets before march 1st
# def find_first_tweet
#  client = starting_client

#  a = []
# 	client.search(:q=> "@kissmetrics",  :until => "2013-03-01").map do |t|
# 		a << t
# 	end		

# 	tweet = a.last
# 	return tweet

# end

def count_tweets

	client = starting_client

	# first_tweet = find_first_tweet

	counts = Hash.new(0)

	tweets = []


	client.search("to:kissmetrics since:2014-03-01").map do |tweet|

	# puts JSON.pretty_generate(tweet.to_h) - used to see what data looks like

		d = tweet.created_at.to_s.split
		date = d[0]
		tweets << date
	end

	tweets.each { |date| counts[date] += 1 }

	return counts

end
