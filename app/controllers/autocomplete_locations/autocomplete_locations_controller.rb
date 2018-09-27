module AutocompleteLocations
  class AutocompleteLocationsController < ActionController::Base

      def add_city
        unless params[:city] && params[:state] && params[:latitude] && params[:longitude]
          render nothing: true, status: 200, content_type: 'text/html'
          return
        end
        new_params = city_params
        new_params[:state] = State.state_id(new_params[:state].titleize)
        new_params[:default_city] = false

        default_searched_city = "#{params[:city]}, #{params[:state]}"
        default_searched_city = AutocompleteLocations::AutocompleteLocation.current_city_name? default_searched_city

        current_default_city = AutocompleteLocation.find_by(state: new_params[:state], city: default_searched_city)
        if current_default_city
          if default_searched_city == params[:city]
            render json: current_default_city, status: 200, content_type: 'text/html'
            return
          end
          new_params[:city_id] = current_default_city[:city_id]
        else
          new_params[:city_id] = AutocompleteLocation.maximum(:city_id).to_i == 0 ? 1 : AutocompleteLocation.maximum(:city_id).to_i + 1
          new_params[:default_city] = default_searched_city == params[:city]
          # If it is false, two cities need to be created, one that is received, one as the default city
          unless new_params[:default_city]
            default_city_params = Hash.new.merge new_params
            default_city_params[:city] = default_searched_city
            default_city_params[:default_city] = true
            default_city = AutocompleteLocation.new(default_city_params)
            default_city.save!
          end
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
          city[:label] = "#{city[:city]}, #{city[:state]}"
          city[:value] = AutocompleteLocation.default_city(city[:id])[:city]
          cities << city
        end
        render json: cities
      end

      private

        def city_params
          params.permit(:id, :city, :city_id, :state, :latitude, :longitude, :default_city).to_h
        end
  end
end