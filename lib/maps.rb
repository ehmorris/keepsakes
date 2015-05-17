include ActionView::Helpers::DateHelper

module Maps
  def place_to_geodata_point(segment, storyline_timezone)
    place = segment['place']
    title = place['name'].nil? ? '(unnamed)' : place['name']
    arrival = Time.parse(segment['startTime']).
              in_time_zone(storyline_timezone).
              strftime("%I:%M%P")
    duration = distance_of_time_in_words(
      Time.parse(segment['startTime']),
      Time.parse(segment['endTime']))

    {'type' => 'Point',
     'coordinates' => [place['location']['lon'], place['location']['lat']],
     'title' => title,
     'arrival' => arrival,
     'duration' => duration,
     'starttime' => Time.parse(segment['startTime']).to_i,
     'endtime' => Time.parse(segment['endTime']).to_i}
  end

  def trackpoints_to_geodata_multiline(activity, trackpoints)
    coordinates = []
    trackpoints.each_with_index do |trackpoint, i|
      unless trackpoints[i + 1].nil?
        trackpoint_1 = trackpoint
        trackpoint_2 = trackpoints[i + 1]

        # http://geojson.org/geojson-spec.html#linestring
        linestring_coordinate_array = [
          [trackpoint_1['lon'], trackpoint_1['lat']],
          [trackpoint_2['lon'], trackpoint_2['lat']]
        ]

        coordinates.push(linestring_coordinate_array)
      end
    end

    {'type' => 'MultiLineString',
     'coordinates' => coordinates,
     'activity' => activity}
  end

  def storyline_timezone(storyline_segments_hash)
    storyline_segments_hash.each do |segment|
      if segment['type'] == 'place'
        location = segment['place']['location']
        timezone = Timezone::Zone.new :latlon => [location['lat'], location['lon']]
        return timezone.active_support_time_zone
      end
    end
  end

  def storyline_to_geodata(storyline_segments_hash, storyline_timezone)
    geodata_hash = []
    storyline_segments_hash.each do |segment|
      if segment['type'] == 'place'
        geodata_hash.push(place_to_geodata_point(segment, storyline_timezone))
      elsif segment['type'] == 'move'
        segment['activities'].each do |activity|
          geodata_hash.push(
            trackpoints_to_geodata_multiline(
              activity['activity'],
              activity['trackPoints']))
        end
      end
    end

    geodata_hash.to_json
  end


  def all_places(storyline_segments_hash, storyline_timezone)
    places_hash = []
    storyline_segments_hash.each do |segment|
      places_hash.push(place_to_geodata_point(segment, storyline_timezone)) if segment['type'] == 'place'
    end

    places_hash
  end
end
