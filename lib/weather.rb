module Weather
  include Oauth

  def get_weather_by_location_and_day(places, day)
    flipped_coordinates = places.first['coordinates'].reverse!
    beginning_city = Geocoder.search(flipped_coordinates)
      .first.address_components.third['long_name']
    return { 'high' => '75', 'low' => '60', 'city' => beginning_city }
  end
end
