require 'active_model_serializers'

ActiveModel::Serializer.setup do |config|
  config.embed = :ids
  config.embed_in_root = true
end

class CountrySerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :continent, :wikipedia_link, :keywords

  has_many :regions
  has_many :airports

  def keywords
    object.keywords.try(:split, ',')
  end
end
