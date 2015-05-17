class DaysController < ApplicationController
  include Moves
  include Instagram 
  include Maps
  include Weather

  before_filter :authorize

  def show
    day = params['id']

    @yesterday = Date.parse(day) - 1
    @today = Date.parse(day)
    @tomorrow = Date.parse(day) + 1

    @geodata_json, @places, @weather, @texts, @instagram_photos, @timezone = nil

    if current_user.uploaded_texts?
      @texts = current_user.texts.
               where(timestamp: @today.beginning_of_day..@today.end_of_day).
               order(:timestamp)
    end

    if current_user.connected_instagram?
      @instagram_photos = get_day_photos(day)
    end

    if current_user.connected_moves?
      storyline_segments_hash = get_storyline_segments_hash(day)

      if storyline_segments_hash
        @timezone = storyline_timezone(storyline_segments_hash)
        @geodata_json = storyline_to_geodata(storyline_segments_hash, @timezone)
        @places = all_places(storyline_segments_hash, @timezone)
        @weather = get_weather_by_location_and_day(@places, day)
      end
    end

    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end
end
