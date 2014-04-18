module Maps
  def place_to_geodata_point(segment)
    lon = segment['place']['location']['lon']
    lat = segment['place']['location']['lat']
    title = segment['place']['name']
    arrival_time = segment['startTime']
    departure_time = segment['endTime']

    {'type' => 'Point',
     'coordinates' => [lon, lat],
     'title' => title,
     'arrival' => arrival_time,
     'departure' => departure_time}
  end

  def trackpoints_to_geodata_line(trackpoint_1, trackpoint_2, activity)
    beginning_lon = trackpoint_1['lon']
    beginning_lat = trackpoint_1['lat']
    end_lon = trackpoint_2['lon']
    end_lat = trackpoint_2['lat']

    {'type' => 'LineString',
     'coordinates' => [
      [beginning_lon, beginning_lat],
      [end_lon, end_lat]],
     'activity' => activity}
  end

  def storyline_to_geodata(storyline_segments_hash)
    geodata_hash = []
    storyline_segments_hash.each do |segment|
      if segment['type'] == 'place'
        geodata_hash.push(place_to_geodata_point(segment))
      elsif segment['type'] == 'move'
        segment['activities'].each do |activity|
          activity_type = activity['activity']
          activity['trackPoints'].each_with_index do |trackpoint, i|
            unless activity['trackPoints'][i + 1].nil?
              geodata_hash.push(
                trackpoints_to_geodata_line(
                  trackpoint,
                  activity['trackPoints'][i + 1],
                  activity_type))
            end
          end
        end
      end
    end

    geodata_hash.to_json
  end
end
