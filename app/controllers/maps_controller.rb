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
        storyline_hash_alldays = [get_storyline_day_hash(storyline_from.to_s)]
        storyline_from.upto(storyline_to) do |day|
          storyline_hash = get_storyline_day_hash(day.to_s)
          storyline_hash_alldays.push(storyline_hash)
        end
        @geodata_json = storyline_to_geodata storyline_hash_alldays.join
      else
        storyline_day = params['date'] || Date.today
        storyline_hash = get_storyline_day_hash(storyline_day)
        @geodata_json = storyline_to_geodata(storyline_hash)
      end
    end
  end
end
