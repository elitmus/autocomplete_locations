# -*- encoding : utf-8 -*-
#DO NOT change the numbers associated with states. If adding a new state, increment the highest number and use it
#DO NOT change the order of the states
module AutocompleteLocations

    module StateFindHelper

      $states = {
        "Andaman and Nicobar"=>"0",
        "Andhra Pradesh"=>"1",
        "Arunachal Pradesh"=>"2",
        "Assam"=>"3",
        "Bihar"=>"4",
        "Chhattisgarh"=>"5",
        "Dadar and Nagar Haveli"=>"6",
        "Daman and Diu"=>"7",
        "Delhi"=>"8",
        "Goa"=>"9",
        "Gujarat"=>"10",
        "Haryana"=>"11",
        "Himachal Pradesh"=>"12",
        "Jammu and Kashmir"=>"13",
        "Jharkhand"=>"14",
        "Karnataka"=>"15",
        "Kerala"=>"16",
        "Lakshadweep"=>"17",
        "Madhya Pradesh"=>"18",
        "Maharashtra"=>"19",
        "Manipur"=>"20",
        "Meghalaya"=>"21",
        "Mizoram"=>"22",
        "Nagaland"=>"23",
        "Odisha"=>"24",
        "Puducherry"=>"25",
        "Punjab"=>"26",
        "Rajasthan"=>"27",
        "Sikkim"=>"28",
        "Tamil Nadu"=>"29",
        "Tripura"=>"30",
        "Uttarakhand"=>"31",
        "Uttar Pradesh"=>"32",
        "West Bengal"=> "33",
        "Chandigarh"=>"34",
        "Telangana"=>"35"
      }

      def state_select(label, *args)
        select(label,$states.sort,*args)
      end

      def state_select_tag(label,selected,*args)
        select_tag(label,"<option value=''>---please select---</option>".html_safe+
            options_for_select($states.sort,selected),*args)
      end

      def self.state_name(id)
        (id.blank? ? "" : $states.key(id.to_s).to_s)
      end

      def self.state_id(name)
        (name.blank? ? "" : $states[name.to_s].to_s)
      end

    end

end