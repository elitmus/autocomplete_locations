# AutocompleteLocations

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/autocomplete_locations`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'autocomplete_locations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install autocomplete_locations

Mount it in routes.rb:

    mount AutocompleteLocations::Engine => "/"

Load javascript file in application.js:

    //= require autocomplete_locations/location_autocomplete


Run rake task:

    $ rake location_fixes:init_autocomplete_locations_module
    $ rake db:migrate
    $ rake location_fixes:update_locations

## Usage

To add location as a reference to your table:

    $ rake location_fixes:add_location_to_table table='TableName'

If the table is already populated with some city name:

    $ rake location_fixes:update_location_to_model model='ModelName' column='city_column_name'

For a model having autocomplete_location_id, search query can be concatenated for finding cities with same city_id:

    ModelNAme.at_city_id(autocomplete_location_id, location) #location is the city name, which is optional

Enabling javascript on an autocomplete_field:

    $("#city_input_field_id").locationAutocomplete(data, "#hidden_city_id_field", "#city_input_field_id", "#state_field_id option");


## Testing

In your factories.rb, require autocomplete_location gem's factories.

    require 'autocomplete_locations/factories'

For each tables with autocomplete_location_id as a foreign key, add this line:

    autocomplete_location_id { create(:autocomplete_locations).id }

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elitmus/autocomplete_locations.

Problems:
What if same city name exist in different states%