require 'mongo'
require 'mongo_mapper'

class Mentions
	include MongoMapper::Document
	
	key :id, Integer, :required => true
	key :created_at, Time, :required => true
	key :text, String, :required => true
	key :name, String, :required => true
	key :user, String, :required => true


end

Mentions.ensure_index [[:id, 1]], :unique => true