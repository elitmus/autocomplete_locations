AutocompleteLocations::Engine.routes.draw do
  get 'all_cities/' => 'autocomplete_locations#all_cities'
  get 'add_city/' => 'autocomplete_locations#add_city'
end
