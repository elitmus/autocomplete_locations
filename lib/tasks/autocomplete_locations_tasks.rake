namespace :location_fixes do
  desc "Init autocomplete locations module"
  task init_autocomplete_locations_module: :environment do
    cmd = "bin/rails g migration CreateAutocompleteLocations city_id:integer city:string state:integer latitude:decimal{7.4} longitude:decimal{7.4} default_city:boolean"
    sh cmd
  end

  desc "Add location reference to existing table"
  task add_location_to_table: :environment do |t, args|
    cmd = "bin/rails g migration AddAutocompleteLocationTo#{ENV['table']} autocomplete_location:references"
    sh cmd
    sh 'rake db:migrate'
  end

  desc "Update previous records of location"
  task update_location_to_model: :environment do
    puts "===============started at #{Time.now}==============="
    puts "Updating previous location records in #{ENV['model']}..."
    cities = AutocompleteLocations::AutocompleteLocation.all
    cities.each do |city|
      ENV['model'].safe_constantize.where(["#{ENV['column']} like ?", "%#{city[:city]}%"]).update_all(autocomplete_location_id: city[:id])
    end
    puts "===============ended at #{Time.now}==============="
  end

  desc "Update locations."
  task update_locations: :environment do
    puts "===============started at #{Time.now}==============="
    puts "Adding current test locations..."
    cities = {
      "Hyderabad" => {
        latitude: 17.385044,
        longitude: 78.486671,
        state: 35
      },
      "Chennai" => {
        latitude: 13.0826802,
        longitude: 80.2707184,
        state: 29
      },
      "Pune" => {
        latitude: 18.5204303,
        longitude: 73.8567437,
        state: 19
      },
      "Mumbai" => {
        latitude: 19.0759837,
        longitude: 72.8776559,
        state: 19
      },
      "Delhi" => {
        latitude: 28.7040592,
        longitude: 77.1024901,
        state: 8
      },
      "Chandigarh" => {
        latitude: 30.7333148,
        longitude: 76.7794179,
        state: 34
      },
      "Kolkata" => {
        latitude: 22.572646,
        longitude: 88.363895,
        state: 33
      },
      "Ranchi" => {
        latitude: 23.3440997,
        longitude: 85.309562,
        state: 14
      },
      "Trivandrum" => {
        latitude: 8.5241391,
        longitude: 76.9366376,
        state: 16
      },
      "Cochin" => {
        latitude: 9.9312328,
        longitude: 76.267304,
        state: 16
      },
      "Coimbatore" => {
        latitude: 11.0168445,
        longitude: 76.9558321,
        state: 29
      },
      "Indore" => {
        latitude: 22.7195687,
        longitude: 75.8577258,
        state: 18
      },
      "Bhopal" => {
        latitude: 23.2599333,
        longitude: 77.412615,
        state: 18
      },
      "Guwahati" => {
        latitude: 26.1445169,
        longitude: 91.7362365,
        state: 3
      },
      "Kharagpur" => {
        latitude: 22.34601,
        longitude: 87.2319753,
        state: 33
      },
      "Kanpur" => {
        latitude: 26.449923,
        longitude: 80.3318736,
        state: 32
      },
      "Calicut" => {
        latitude: 11.2587531,
        longitude: 75.78041,
        state: 16
      },
      "Vellore" => {
        latitude: 12.9165167,
        longitude: 79.1324986,
        state: 29
      },
      "Warangal" => {
        latitude: 17.9689008,
        longitude: 79.5940544,
        state: 35
      },
      "Durgapur" => {
        latitude: 23.5204443,
        longitude: 87.3119227,
        state: 33
      },
      "Allahabad" => {
        latitude: 25.4358011,
        longitude: 81.846311,
        state: 32
      },
      "Mangalore" => {
        latitude: 12.9141417,
        longitude: 74.8559568,
        state: 15
      },
      "Trichy" => {
        latitude: 10.7904833,
        longitude: 78.7046725,
        state: 29
      },
      "Nagpur" => {
        latitude: 21.1458004,
        longitude: 79.0881546,
        state: 19
      },
      "Dhanbad" => {
        latitude: 23.7956531,
        longitude: 86.4303859,
        state: 14
      },
      "Banaras" => {
        latitude: 25.3176452,
        longitude: 82.9739144,
        state: 32
      },
      "Roorkee" => {
        latitude: 29.8542626,
        longitude: 77.8880002,
        state: 31
      },
      "Jaipur" => {
        latitude: 26.9124336,
        longitude: 75.7872709,
        state: 27
      },
      "Gulbarga" => {
        latitude: 17.329731,
        longitude: 76.8342957,
        state: 15
      },
      "Lucknow" => {
        latitude: 26.8466937,
        longitude: 80.9461659,
        state: 32
      },
      "Nasik" => {
        latitude: 19.9974533,
        longitude: 73.7898023,
        state: 19
      },
      "Belgaum" => {
        latitude: 15.8496953,
        longitude: 74.4976741,
        state: 15
      },
      "Manipal" => {
        latitude: 13.3605015,
        longitude: 74.7863698,
        state: 15
      },
      "Jalandhar" => {
        latitude: 31.3260152,
        longitude: 75.5761829,
        state: 26
      },
      "Mysore" => {
        latitude: 12.2958104,
        longitude: 76.6393805,
        state: 15
      },
      "Visakhapatnam" => {
        latitude: 17.6868159,
        longitude: 83.2184815,
        state: 1
      },
      "CMRIT" => {
        latitude: 12.9668357,
        longitude: 77.7115006,
        state: 15
      },
      "Bhubaneswar" => {
        latitude: 20.2960587,
        longitude: 85.8245398,
        state: 24
      },
      "Kolhapur" => {
        latitude: 16.7049873,
        longitude: 74.2432527,
        state: 19
      },
      "Ahmedabad" => {
        latitude: 23.022505,
        longitude: 72.5713621,
        state: 10
      },
      "Greater Noida" => {
        latitude: 28.4743879,
        longitude: 77.5039904,
        state: 32
      },
      "Bareilly" => {
        latitude: 28.3670355,
        longitude: 79.4304381,
        state: 32
      },
      "Modi Nagar" => {
        latitude: 28.8316307,
        longitude: 77.5779592,
        state: 32
      },
      "Gurgaon" => {
        latitude: 28.4594965,
        longitude: 77.0266383,
        state: 11
      },
      "Meerut" => {
        latitude: 28.9844618,
        longitude: 77.7064137,
        state: 32
      },
      "Faridabad" => {
        latitude: 28.4089123,
        longitude: 77.3177894,
        state: 11
      },
      "Mathura" => {
        latitude: 27.4924134,
        longitude: 77.673673,
        state: 32
      },
      "Yamuna Nagar" => {
        latitude: 30.1290485,
        longitude: 77.2673901,
        state: 11
      },
      "Tumkur" => {
        latitude: 13.3391677,
        longitude: 77.1139984,
        state: 15
      },
      "Silchar" => {
        latitude: 24.8332708,
        longitude: 92.7789054,
        state: 3
      },
      "Gandhinagar" => {
        latitude: 23.2156354,
        longitude: 72.6369415,
        state: 10
      },
      "Ghaziabad" => {
        latitude: 28.6691565,
        longitude: 77.4537578,
        state: 32
      },
      "Sikar" => {
        latitude: 27.6094,
        longitude: 75.139911,
        state: 27
      },
      "Patna" => {
        latitude: 25.5940947,
        longitude: 85.1375645,
        state: 4
      },
      "Bhimtal" => {
        latitude: 29.346082,
        longitude: 79.5519144,
        state: 31
      },
      "Sangivalasa" => {
        latitude: 17.9232372,
        longitude: 83.4208333,
        state: 1
      },
      "Surathkal" => {
        latitude: 12.9807123,
        longitude: 74.8031446,
        state: 15
      },
      "Pilani" => {
        latitude: 28.3802101,
        longitude: 75.6091696,
        state: 27
      },
      "Dehradun" => {
        latitude: 30.3164945,
        longitude: 78.0321918,
        state: 31
      },
      "Jamshedpur" => {
        latitude: 22.8045665,
        longitude: 86.2028754,
        state: 14
      },
      "Sohna" => {
        latitude: 28.2486993,
        longitude: 77.0635117,
        state: 11
      },
      "Dadri" => {
        latitude: 28.5461902,
        longitude: 77.55621,
        state: 32
      },
      "Jagadhri" => {
        latitude: 30.1680858,
        longitude: 77.2969204,
        state: 11
      },
      "Jabalpur" => {
        latitude: 23.181467,
        longitude: 79.9864071,
        state: 18
      },
      "Hubli" => {
        latitude: 15.3647083,
        longitude: 75.1239547,
        state: 15
      },
      "Madurai" => {
        latitude: 9.9252007,
        longitude: 78.1197754,
        state: 29
      },
      "Thiruvananthapuram" => {
        latitude: 8.5241391,
        longitude: 76.9366376,
        state: 16
      },
      "Sonepat" => {
        latitude: 28.9930823,
        longitude: 77.0150735,
        state: 11
      },
      "Kurukshetra" => {
        latitude: 29.9695121,
        longitude: 76.878282,
        state: 11
      },
      "Patiala" => {
        latitude: 30.3397809,
        longitude: 76.3868797,
        state: 26
      },
      "Hoshiarpur" => {
        latitude: 31.5143178,
        longitude: 75.911483,
        state: 26
      },
      "Varanasi" => {
        latitude: 25.3176452,
        longitude: 82.9739144,
        state: 32
      },
      "Vijayawada" => {
        latitude: 16.5061743,
        longitude: 80.6480153,
        state: 1
      },
      "Palwal" => {
        latitude: 28.1487362,
        longitude: 77.3320262,
        state: 11
      },
      "Dwarahat" => {
        latitude: 29.77603,
        longitude: 79.4267845,
        state: 31
      },
      "Anantapur" => {
        latitude: 14.6818877,
        longitude: 77.6005911,
        state: 1
      },
      "Jhansi" => {
        latitude: 25.4484257,
        longitude: 78.5684594,
        state: 32
      },
      "Nashik" => {
        latitude: 19.9974533,
        longitude: 73.7898023,
        state: 19
      },
      "Kurkshetra" => {
        latitude: 29.9695121,
        longitude: 76.878282,
        state: 11
      },
      "Narsapur" => {
        latitude: 16.4329833,
        longitude: 81.6966198,
        state: 1
      },
      "Mesra" => {
        latitude: 23.4306419,
        longitude: 85.4153741,
        state: 14
      },
      "Udaipur" => {
        latitude: 24.585445,
        longitude: 73.712479,
        state: 27
      },
      "Tadepalligudem" => {
        latitude: 16.8138415,
        longitude: 81.521241,
        state: 1
      },
      "Mullana" => {
        latitude: 30.2752852,
        longitude: 77.04758,
        state: 11
      },
      "Thanjavur" => {
        latitude: 10.7869994,
        longitude: 79.1378274,
        state: 29
      },
      "Bilaspur" => {
        latitude: 22.0796251,
        longitude: 82.1391412,
        state: 5
      },
      "Sangli" => {
        latitude: 16.8523973,
        longitude: 74.5814773,
        state: 19
      },
      "Surat" => {
        latitude: 21.1702401,
        longitude: 72.8310607,
        state: 10
      },
      "Raipur" => {
        latitude: 21.2513844,
        longitude: 81.6296413,
        state: 5
      },
      "Bhilai" => {
        latitude: 21.1938475,
        longitude: 81.3509416,
        state: 5
      },
      "Siliguri" => {
        latitude: 26.7271012,
        longitude: 88.3952861,
        state: 33
      },
      "Visakhapatanam" => {
        latitude: 17.6868159,
        longitude: 83.2184815,
        state: 1
      },
      "Aurangabad" => {
        latitude: 19.8761653,
        longitude: 75.3433139,
        state: 19
      },
      "Durg" => {
        latitude: 21.1622986,
        longitude: 81.4278984,
        state: 5
      },
      "Anantpur" => {
        latitude: 14.6818877,
        longitude: 77.6005911,
        state: 1
      },
      "Warrangal" => {
        latitude: 17.9689008,
        longitude: 79.5940544,
        state: 35
      },
      "Haldia" => {
        latitude: 22.0666742,
        longitude: 88.0698118,
        state: 33
      },
      "Rvce Bangalore" => {
        latitude: 12.9237077,
        longitude: 77.4986878,
        state: 15
      },
      "Pesit Bangalore" => {
        latitude: 12.8614515,
        longitude: 77.6647081,
        state: 15
      },
      "Noida" => {
        latitude: 28.5355161,
        longitude: 77.3910265,
        state: 32
      },
      "Bhubaneshwar" => {
        latitude: 20.2960587,
        longitude: 85.8245398,
        state: 24
      },
      "Puducherry" => {
        latitude: 11.9143535,
        longitude: 79.7371936,
        state: 25
      },
      "Lakshmangarh" => {
        latitude: 27.819749,
        longitude: 75.031909,
        state: 27
      },
      "Katra" => {
        latitude: 40.7217244,
        longitude: 73.9932124,
        state: 0
      },
      "Karad" => {
        latitude: 17.2759841,
        longitude: 74.2003231,
        state: 19
      },
      "Tirupati" => {
        latitude: 13.6287557,
        longitude: 79.4191795,
        state: 1
      },
      "Gwalior" => {
        latitude: 26.2182871,
        longitude: 78.1828308,
        state: 18
      },
      "Jalpaiguri" => {
        latitude: 26.5434772,
        longitude: 88.7205256,
        state: 33
      },
      "Haridwar" => {
        latitude: 29.9456906,
        longitude: 78.1642478,
        state: 31
      },
      "Bangalore" => {
        latitude: 12.9715987,
        longitude: 77.5945627,
        state: 15
      },
      "Bengaluru" => {
        latitude: 12.9715987,
        longitude: 77.5945627,
        state: 15
      },
      "Udhampur" => {
        latitude: 32.9159847,
        longitude: 75.1416173,
        state: 13
      }
    }
    cities.each do |city, data|
      location = AutocompleteLocations::AutocompleteLocation.at_lat_long(data[:latitude], data[:longitude]).limit(1).first
      if location.nil?
        data[:default_city] = true
        data[:city] = city
        data[:city_id] =  AutocompleteLocations::AutocompleteLocation.count == 0 ? 1 : AutocompleteLocations::AutocompleteLocation.last[:id].to_i + 1
      else
        data[:default_city] = false
        data[:city] = city
        data[:city_id] = location[:city_id]
      end
      AutocompleteLocations::AutocompleteLocation.create(data)
    end
    puts "===============ended at #{Time.now}==============="
  end

end