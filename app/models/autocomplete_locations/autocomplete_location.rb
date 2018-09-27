module AutocompleteLocations
  class AutocompleteLocation < ActiveRecord::Base

    reverse_geocoded_by :latitude, :longitude

    self.table_name = 'autocomplete_locations'

    scope :at_lat_long, -> (lat, long) { where(["abs(autocomplete_locations.latitude-#{lat}) <= 1e-4 AND abs(autocomplete_locations.longitude-#{long}) <= 1e-4"]) }
    scope :city_id, -> (city, state=nil) { where(state.nil? ? ["autocomplete_locations.city like ?", "%"+city+"%"] : ["autocomplete_locations.city like ? and autocomplete_locations.state = ?", "%"+city+"%", State.state_id(state)])}
    # return all the id of cities which are same but different names
    scope :same_city_names, -> (id) { where(city_id: find(id).city_id)}

    def self.city_name_ids(id)
      same_city_names(id).select(:id)
    end

    def is_default_city?
      searched_city = "#{self[:city]}, #{AutocompleteLocations::State.state_name(self[:state])}"
      AutocompleteLocations.current_city_name?(searched_city) == self[:city]
    end

    def self.default_city(id)
      default_city = AutocompleteLocation.find_by(city_id: AutocompleteLocation.find(id).city_id, default_city: true)
      default_city || AutocompleteLocation.find(id)
    end

    def self.current_city_name?(query)
      # Try query with city name and state both. Ex: query = 'Aurangabad, Uttar Pradesh'
      searched_city = Geocoder.search query
      searched_city[0].data['address_components'].each do |options|
        return options['long_name'] if options['types'].include?('locality') && options['types'].include?('political')
      end
      return nil
    end
  end
end
