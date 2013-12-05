require 'active_record'
require 'activerecord-import'

ActiveRecord::Base.establish_connection(
  YAML.load(IO.read('../settings.yml'))['database']['development']
)
