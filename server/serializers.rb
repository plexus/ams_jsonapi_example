require 'active_model_serializers'

class CountrySerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :continent, :wikipedia_link, :keywords

  has_many :regions, embed: :ids, embed_in_root: true
  has_many :airports, embed: :ids, embed_in_root: true

  def keywords
    object.keywords.try(:split, ',')
  end
end
