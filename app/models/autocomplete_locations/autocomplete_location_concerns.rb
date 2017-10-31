module AutocompleteLocations
  module AutocompleteLocationConcerns
    extend ActiveSupport::Concern
    included do

      has_one :autocomplete_location
      before_validation :validate_city_location

      HUMANIZED_ATTRIBUTES ||= {autocomplete_location_id: 'Location'}

      def self.human_attribute_name(attr, options = {})
        HUMANIZED_ATTRIBUTES[attr.to_sym] || super
      end

      def self.at_city_id(id)
        where(autocomplete_location_id: AutocompleteLocation.city_name_ids(id))
      end

      def self.city_id(city, state=nil)
        attrib = {city: city}
        attrib = attrib.merge({state: State.state_id(state)}) unless state.nil?
        AutocompleteLocation.find_by(attrib).try(:id)
      end

      def validate_city_location
        self.autocomplete_location_id = self.class.name.constantize.city_id(self.location)
      end

    end
  end
end