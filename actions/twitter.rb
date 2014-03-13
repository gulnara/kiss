require 'twitter'
require 'json'

module TwitterGrapher

	class SearchHelper

		attr_reader :client

		def initialize(client_init)
			@client = client_init
		end

		def self.create
			new_client = Twitter::REST::Client.new do |config|
				config.consumer_key    = "key"
				config.consumer_secret = "key"
				config.access_token        = "key"
				config.access_token_secret = "key"
			end
			TwitterGrapher::SearchHelper.new(new_client)
		end

		def count_tweets(user)
			counts = Hash.new(0)
			tweets = client.search("to:#{user} since:2014-03-01").map do |tweet|
				splitting_date = tweet.created_at.to_s.split 
				date = splitting_date[0]
			end
			tweets.each { |date| counts[date] += 1 }
			return counts
		end
	end
end
