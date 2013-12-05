require 'active_model_serializers'

class CountrySerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :continent, :wikipedia_link, :keywords

  def keywords
    object.keywords.try(:split, ',')
  end
end
