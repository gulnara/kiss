require 'twitter'
require 'json'

def starting_client

	client = Twitter::REST::Client.new do |config|
		config.consumer_key    = "key"
		config.consumer_secret = "key"
		config.access_token        = "key"
		config.access_token_secret = "key"
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
