class DaysController < ApplicationController
  include Moves
  include Instagram 
  include Maps
  include Weather

  before_filter :authorize, :moves_connected, :instagram_connected

  def show
    storyline_day = params['id']

    @yesterday = Date.parse(storyline_day) - 1
    @today = Date.parse(storyline_day)
    @tomorrow = Date.parse(storyline_day) + 1

    @instagram_photos = get_day_photos(storyline_day)
    @geodata_json, @places, @weather = nil
    storyline_segments_hash = get_storyline_segments_hash(storyline_day)
    if storyline_segments_hash
      @geodata_json = storyline_to_geodata(storyline_segments_hash)
      @places = all_places(storyline_segments_hash)
      @weather = get_weather_by_location_and_day(@places, storyline_day)
    end

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  private

  def moves_connected
    redirect_to root_url unless valid_moves_access_token?(current_user.moves_access_token)
  end

  def instagram_connected
    redirect_to root_url unless valid_instagram_access_token?(current_user.instagram_access_token)
  end
end
