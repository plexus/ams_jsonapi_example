require 'sinatra'
require_relative 'models'
require_relative 'serializers'

ActiveModel::Serializer.setup do |config|
  config.embed = :ids
  config.embed_in_root = true
end

get '/countries' do
  ActiveModel::ArraySerializer.new(
    Country.limit(20),
    resource_name: 'countries'
  ).to_json
end

get '/country/:code' do
  CountrySerializer.new(
    Country.where(code: params[:code]).first,
    resource_name: 'countries'
  ).to_json
end
