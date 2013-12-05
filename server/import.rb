#!/usr/bin/env ruby

require 'csv'
require_relative '../server/database'

def read_data(name)
  data = CSV.read("../db/#{name}.csv", headers: true)
  data.headers.grep(/^type$/).each {|f| f.gsub!(/^/, '_') }
  data
end

tables = {
  'countries' => {},
  'regions'   => [
    [ 'iso_country', 'Country', 'code', 'country_id' ],
  ],
  'airports'  => [
    [ 'iso_country', 'Country', 'code', 'country_id' ],
    [ 'iso_region',  'Region',  'code', 'region_id'  ]
  ],
  'runways'   => [
    [ 'airport_ref', 'Airport', 'id',   'airport_id' ]
  ]
}


tables.each do |name, mappings|
  data = read_data(name)
  id_fields = mappings.map(&:last)

  ActiveRecord::Migration.class_eval do
    create_table name do |t|
      (data.headers - ["id"]).each do |col|
        t.string col
      end
      id_fields.each do |col|
        t.integer col
      end
    end
  end
end

require_relative '../server/models'

tables.each do |name, mappings|
  puts "-- importing #{name}"
  data = read_data(name)

  model = name.singularize.camelize.constantize

  model.import(data.map do |row|
      associations = mappings.each_with_object({}) do |(ref, ref_model, src_field, dst_field), assoc|
        assoc[dst_field] = ref_model.constantize.where(src_field => row[ref]).pluck("id").first
      end

      model.new(row.to_hash.merge(associations))
    end
  )
end
