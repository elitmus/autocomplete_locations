module AutocompleteLocations
  class AutocompleteLocation < ActiveRecord::Base
    self.table_name = 'autocomplete_locations'
    scope :at_lat_long, lambda { |lat, long| where(["abs(autocomplete_locations.latitude-#{lat}) <= 1e-4 AND abs(autocomplete_locations.longitude-#{long}) <= 1e-4"]) }

  end
end