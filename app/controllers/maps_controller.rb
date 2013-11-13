class MapsController < ApplicationController
  include Moves
  include Maps

  def index
    if session[:access_token].nil?
      @moves_authorize_uri = moves_client.auth_code.authorize_url(
        :redirect_uri => moves_redirect_uri,
        :scope => 'activity location')
      render 'maps/signin'
    else
      if params['from'] and params['to']
        storyline_from = Date.parse(params['from'])
        storyline_to = Date.parse(params['to'])
        storyline_geodata_alldays = []
        storyline_from.upto(storyline_to) do |day|
          storyline_segments_hash = get_storyline_segments_hash(day.to_s)
          storyline_geojson = storyline_to_geodata(storyline_segments_hash)
          # remove brackets from segments
          storyline_geodata_alldays.push(storyline_geojson[0..-2][1..-1])
        end
        # add comma for correct JSON, wrap joined segments in brackets
        @geodata_json = "[#{storyline_geodata_alldays.join(',')}]"
      else
        storyline_day = params['date'] || Date.today
        storyline_segments_hash = get_storyline_segments_hash(storyline_day)
        @geodata_json = storyline_to_geodata(storyline_segments_hash)
      end
    end
  end
end
