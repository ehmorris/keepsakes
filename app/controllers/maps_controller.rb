class MapsController < ApplicationController
  include Moves
  include Maps

  before_filter :authorize, :authorized_moves

  def index
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

  private

  def authorized_moves
    current_user.moves_access_token
  end
end
