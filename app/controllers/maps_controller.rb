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
        storyline_json_alldays = []
        storyline_from.upto(storyline_to) do |day|
          storyline_json = get_storyline_day_json(day.to_s)
          storyline_json_alldays = storyline_json_alldays.concat(storyline_json)
        end
        @geodata_json = storyline_to_geodata(storyline_json_alldays)
      else
        storyline_day = params['date'] || Date.today
        storyline_json = get_storyline_day_json(storyline_day)
        @geodata_json = storyline_to_geodata(storyline_json)
      end
    end
  end
end
