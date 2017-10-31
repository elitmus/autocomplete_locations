require 'factory_bot'
require_relative '../../app/models/autocomplete_locations/autocomplete_location'
FactoryBot.define do
  factory :autocomplete_locations, :class => AutocompleteLocations::AutocompleteLocation do
    sequence(:id) {|n| n}
    state 15
    city_id 1
    city "Bangalore"
    latitude 12.9716
    longitude 77.5946
    default_city true
  end
end