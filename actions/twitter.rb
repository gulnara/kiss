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
				config.consumer_key    = "S4ScCFIvESlN2FbLNtvg"
				config.consumer_secret = "rzFnfXmCcuLSE3O8OeQ3h3V2ugoXlEDUhdu7tulPcU8"
				config.access_token        = "369737491-kh0ruoo7yWlr2VYc5u1EZRZqCJqmKi3RqbL2Zwwk"
				config.access_token_secret = "pcpw87tSAeVu8JQpNftoLA4E3raaSIGbSUeG4EewwvKrA"
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
