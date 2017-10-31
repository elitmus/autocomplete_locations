module AutocompleteLocations
  class AutocompleteLocation < ActiveRecord::Base

    self.table_name = 'autocomplete_locations'

    scope :at_lat_long, -> (lat, long) { where(["abs(autocomplete_locations.latitude-#{lat}) <= 1e-4 AND abs(autocomplete_locations.longitude-#{long}) <= 1e-4"]) }
    scope :city_id, -> (city, state=nil) { where(state.nil? ? ["autocomplete_locations.city like ?", "%"+city+"%"] : ["autocomplete_locations.city like ? and autocomplete_locations.state = ?", "%"+city+"%", State.state_id(state)])}
    # return all the id of cities which are same but different names
    scope :same_city_names, -> (id) { where(city_id: find(id).city_id)}

    def self.city_name_ids(id)
      same_city_names(id).select(:id)
    end

  end
end