class MapsController < ApplicationController
  include MovesAuth
  include Maps

  def index
    if session[:access_token].nil?
      @moves_authorize_uri = moves_client.auth_code.authorize_url(
        :redirect_uri => moves_redirect_uri,
        :scope => 'activity location')
      render 'maps/signin'
    else
      storyline_day = params['date'] || Date.today
      storyline_json = moves_access_token.get(
        "/api/v1/user/storyline/daily/#{storyline_day}?trackPoints=true")
        .parsed
        .first

      # coordinates here are in longitude, latitude order because x, y is the
      # standard for GeoJSON
      geodata_hash = []
      storyline_json['segments'].each do |segment|
        if segment['type'] == 'place'
          geodata_hash.push(place_to_geodata_point(segment))
        elsif segment['type'] == 'move'
          segment['activities'].each do |activity|
            activity['trackPoints'].each_with_index do |trackpoint, i|
              unless activity['trackPoints'][i + 1].nil?
                geodata_hash.push(
                  trackpoints_to_geodata_line(
                    trackpoint,
                    activity['trackPoints'][i + 1]))
              end
            end
          end
        end
      end

      @geodata_json = geodata_hash.to_json
    end
  end
end
