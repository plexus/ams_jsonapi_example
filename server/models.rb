require_relative 'database'

class Country < ActiveRecord::Base
end

class Region  < ActiveRecord::Base
  belongs_to :country
  has_many :airports
end

class Airport < ActiveRecord::Base
  belongs_to :region
  belongs_to :country

  has_many :runways
end

class Runway < ActiveRecord::Base
  belongs_to :airport
end
