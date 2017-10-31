module AutocompleteLocations
  class AutocompleteLocationsController < ActionController::Base

      def add_city
        unless params[:city] && params[:state] && params[:latitude] && params[:longitude]
          render nothing: true, status: 200, content_type: 'text/html'
          return
        end
        new_params = AutocompleteLocationsController.get_params params
        new_params[:state] = State.state_id(new_params[:state].titleize)
        similar_city = AutocompleteLocation.at_lat_long(params[:latitude], params[:longitude]).first
        if similar_city
          new_params[:city_id] = similar_city[:city_id]
          new_params[:default_city] = false
        else
          new_params[:city_id] = AutocompleteLocation.count == 0 ? 1 : AutocompleteLocation.last[:id].to_i + 1
          new_params[:default_city] = true
        end
        location = AutocompleteLocation.new(new_params)
        location.save!
        render json: location
      end

      def all_cities
        locations = AutocompleteLocation.all.to_json
        locations = JSON.parse(locations)
        cities = []
        locations.each do |location|
          city = {}
          city[:id] = location['id']
          city[:city] = location['city']
          city[:state] = State.state_name(location['state'])
          city[:label] = city[:city]
          city[:value] = city[:city]
          cities << city
        end
        render json: cities
      end

      def self.get_params(params)
        keys = %w{id city city_id state latitude longitude default_city}
        obj = {}
        keys.each do |key|
          obj[key.to_sym] = params[key.to_sym] if params[key.to_sym]
        end
        obj
      end

  end
end