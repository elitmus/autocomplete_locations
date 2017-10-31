jQuery.fn.extend({
  // While searching for locations, first we'll lookup in our own database. If not found, then in google APIs


  locationAutocomplete: function(sourceData, city_id_field, city_field, state_field) {
    var element = $(this);
    var api_key = "AIzaSyCZKYyehirTIx6_ELgPSzbJkxw3kuW6k-0";
    $.getScript("https://maps.googleapis.com/maps/api/js?libraries=places&key="+api_key, function() {
      google.maps.event.addDomListener(window, "load", function(){});
    }); //&callback=fooBarFunction

    var loadMap = function(query) {
      element.autocomplete('destroy');
      try {
        // Google places API
          var places = new google.maps.places.Autocomplete(element.get(0), { types: ['(cities)'] });
          google.maps.event.addListener(places, 'place_changed', function () {
            var place = places.getPlace();
            var city = place.name;
            var state = place.address_components[2];
            if(state.long_name == 'India')
              state = place.address_components[1];
            var latitude = place.geometry.location.lat();
            var longitude = place.geometry.location.lng();
            //save new location, and get the result
              $.ajax({
                url: '/add_city',
                data: {'city' : city, 'latitude' : latitude, 'longitude' : longitude, 'state' : state.long_name},
                type: 'get',
                dataType: 'json',
                success: function(data) {
                    setLocation(data['id'], data['city'], state.long_name);
                },
                error: function() {
                    alert("Couldn't add new location to server! Try again.");
                }
              });
          });
          // Fire maps places API event, by
          element.blur();
          setTimeout(function(){ element.focus(); }, 300);
          console.log("Map loaded!");
     } catch(err) {
        console.log(err);
        console.log("Unable to load Google Map");
     }
  }


  var setLocation = function(city_id, city, state) {
    console.log("City id: "+city_id);
    $(city_id_field).val(city_id);
    $(city_field).val(city);
    $(state_field).filter(function() {
        //may want to use $.trim in here
        return $(this).text() == state;
    }).prop('selected', true);

  }

  element.autocomplete({
    source: sourceData,
    select: function(event, ui) {
              if(ui.item.location_state == 0){
                loadMap(this.value);
              }
              else{
                setLocation(ui.item.id, ui.item.city, ui.item.state);
              }
            },
    response: function(event, ui) {
            if (!ui.content.length) {
              //'Other' option can only be appended to non empty list
              var blank_item = { value:"", label:"Other", location_state:0};
              ui.content.push(blank_item);
            }
    }
  });
  return this;
  }
});
