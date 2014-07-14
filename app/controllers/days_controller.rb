class DaysController < ApplicationController
  include Moves
  include Instagram 
  include Maps

  before_filter :authorize, :authorized_moves

  def show
    moves_is_connected = valid_moves_access_token?(current_user.moves_access_token)
    instagram_is_connected = valid_instagram_access_token?(current_user.instagram_access_token)
    
    if !moves_is_connected and !instagram_is_connected
      redirect_to root_url
    end
    
    storyline_day = params['id']
    storyline_segments_hash = get_storyline_segments_hash(storyline_day)
    if storyline_segments_hash
      @geodata_json = storyline_to_geodata(storyline_segments_hash)
      @places = all_places(storyline_segments_hash)
    else
      @geodata_json, @places = []
    end

    @instagram_photos = get_day_photos(storyline_day)
    
    @yesterday = Date.parse(storyline_day) - 1
    @today = Date.parse(storyline_day)
    @tomorrow = Date.parse(storyline_day) + 1

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  private

  def authorized_moves
    current_user.moves_access_token
  end
end
