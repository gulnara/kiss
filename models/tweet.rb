require 'mongo'
require 'mongo_mapper'

class Mention
	include MongoMapper::Document

	key :tweet_id, Integer, :required => true
	key :created_at, Time, :required => true
	key :text, String, :required => true
	key :name, String, :required => true
	key :user, String, :required => true


end

Mention.ensure_index [[:tweet_id, 1]], :unique => true
