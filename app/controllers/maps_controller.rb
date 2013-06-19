class MapsController < ApplicationController
  include MovesAuth
  
  def index
    if session[:access_token].nil?
      @moves_authorize_uri = moves_client.auth_code.authorize_url(
        :redirect_uri => moves_redirect_uri,
        :scope => 'activity location')
      render 'maps/signin'
    else
      storyline_day = params['date'] || Date.today
      storyline_json = moves_access_token.get(
        "/api/v1/user/storyline/daily/#{storyline_day}?trackPoints=true").parsed

      @geojson = []

      # coordinates here are in longitude, latitude order because
      # x, y is the standard for GeoJSON and many formats
      storyline_json.each do |date|
        date['segments'].each do |segment|
          if segment['type'] == 'place'
            lon = segment['place']['location']['lon']
            lat = segment['place']['location']['lat']
            @geojson.push({'type' => 'Point', 'coordinates' => [lon, lat]})
          elsif segment['type'] == 'move'
            segment['activities'].each do |activity|
              activity['trackPoints'].each_with_index do |trackpoint, i|
                if activity['trackPoints'][i + 1]
                  beginning_lon = trackpoint['lon']
                  beginning_lat = trackpoint['lat']
                  end_lon = activity['trackPoints'][i + 1]['lon']
                  end_lat = activity['trackPoints'][i + 1]['lat']
                  @geojson.push(
                    {'type' => 'LineString',
                     'coordinates' => [
                       [beginning_lon, beginning_lat],
                       [end_lon, end_lat]]})
                end
              end
            end
          end
        end
      end

      @geojson = @geojson.to_json
    end
  end
end
