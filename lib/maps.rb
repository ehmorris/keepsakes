module Maps
  def place_to_geodata_point(segment)
    lon = segment['place']['location']['lon']
    lat = segment['place']['location']['lat']
    title = segment['place']['name']

    {'type' => 'Point', 'coordinates' => [lon, lat], 'title' => title}
  end

  def trackpoints_to_geodata_line(trackpoint_1, trackpoint_2)
    beginning_lon = trackpoint_1['lon']
    beginning_lat = trackpoint_1['lat']
    end_lon = trackpoint_2['lon']
    end_lat = trackpoint_2['lat']

    {'type' => 'LineString', 'coordinates' => [
      [beginning_lon, beginning_lat],
      [end_lon, end_lat]]}
  end
end
