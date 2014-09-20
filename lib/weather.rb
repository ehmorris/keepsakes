module Weather
  include Oauth

  def get_weather_by_location_and_day(places, day)
    weather = Wunderground.new(ENV['WUNDERGROUND_KEY'])
    flipped_coordinates = places.first['coordinates'].reverse!.join(',')
    historic_weather = weather.history_for(Date.parse(day), flipped_coordinates)
    low = historic_weather['history']['dailysummary'][0]['mintempi']
    high = historic_weather['history']['dailysummary'][0]['maxtempi']
    return { 'high' => high, 'low' => low }
  end
end
