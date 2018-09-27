require 'autocomplete_locations/engine'
require 'geocoder'
require 'redis'
module AutocompleteLocations

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :google_places_api_key

    def initialize
      @google_places_api_key = ''
    end
  end
end
