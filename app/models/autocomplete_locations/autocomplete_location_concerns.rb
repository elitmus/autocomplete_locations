module AutocompleteLocations
  module AutocompleteLocationConcerns
    extend ActiveSupport::Concern
    included do
      scope :at_city_id, lambda {|city_id, city = nil| joins("INNER JOIN autocomplete_locations ON autocomplete_locations.id = #{self.table_name}.autocomplete_location_id").where(!city_id.zero? ? ["autocomplete_locations.city_id = (select city_id from autocomplete_locations where id=?) and #{self.table_name}.autocomplete_location_id = autocomplete_locations.id", city_id] : city.nil? ? nil : ["#{self.table_name}.location like ?", "%"+city+"%"])}
    end
  end
end