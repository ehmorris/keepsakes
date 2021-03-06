module Instagram
  include Oauth
  include ActionView::Helpers::DateHelper
  
  def instagram_client
    OAuth2::Client.new(
      ENV['INSTAGRAM_CLIENT_ID'],
      ENV['INSTAGRAM_CLIENT_SECRET'],
      :site => 'https://api.instagram.com',
      :authorize_url => "https://api.instagram.com/oauth/authorize",
      :token_url => 'https://api.instagram.com/oauth/access_token')
  end

  def instagram_access_token
    OAuth2::AccessToken.new(instagram_client, current_user.instagram_access_token)
  end

  def valid_instagram_access_token?(access_token)
    if current_user.instagram_user_id.nil?
      false
    else
      uri = URI.parse('https://api.instagram.com')
      uri.path = "/v1/users/#{current_user.instagram_user_id}"
      uri.query = "access_token=#{access_token}"

      response = get_request_to_hash(uri)
      response['meta']['error_type'].nil?
    end
  end

  def get_day_photos(day)
    min = DateTime.parse(day).beginning_of_day.to_time.to_i
    max = DateTime.parse(day).end_of_day.to_time.to_i
    full_photos_hash = instagram_access_token.get(
      "/v1/users/#{current_user.instagram_user_id}/media/recent?min_timestamp=#{min}&max_timestamp=#{max}&access_token=#{current_user.instagram_access_token}")
      .parsed['data']

    images_and_captions = []
    
    full_photos_hash.each do |photo|
      caption = photo['caption'].nil? ? '' : photo['caption']['text'] 
      
      if photo['type'] == 'video'
        images_and_captions.push({
          'url' => photo['videos']['standard_resolution']['url'],
          'caption' => caption,
          'type' => 'video',
          'timestamp' => photo['created_time']
        })
      else
        images_and_captions.push({
          'url' => photo['images']['standard_resolution']['url'],
          'caption' => caption,
          'type' => 'image',
          'timestamp' => photo['created_time']
        })
      end
    end

    images_and_captions
  end

  def instagram_redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/instagram/callback'
    uri.query = nil
    uri.to_s
  end
end

