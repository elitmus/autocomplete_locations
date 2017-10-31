Rails.application.routes.draw do
  mount AutocompleteLocations::Engine => "/autocomplete_locations"
end
