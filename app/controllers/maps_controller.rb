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

      @geodata_json = storyline_to_geodata(storyline_json)
    end
  end
end
