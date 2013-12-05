require 'sinatra'
require_relative 'models'
require_relative 'serializers'

get '/countries' do
  ActiveModel::ArraySerializer.new( Country.limit(20) ).to_json
end
