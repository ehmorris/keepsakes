module Moves
  include Oauth
  
  def moves_client
    OAuth2::Client.new(
      ENV['MOVES_CLIENT_ID'],
      ENV['MOVES_CLIENT_SECRET'],
      :site => 'https://api.moves-app.com',
      :authorize_url => "https://api.moves-app.com/oauth/v1/authorize",
      :token_url => 'https://api.moves-app.com/oauth/v1/access_token')
  end

  def moves_access_token
    OAuth2::AccessToken.new(
      moves_client,
      current_user.moves_access_token)
  end

  def valid_moves_access_token?(access_token)
    if access_token.nil?
      false
    else
      uri = URI.parse('https://api.moves-app.com')
      uri.path = '/oauth/v1/tokeninfo'
      uri.query = "access_token=#{access_token}"

      response = get_request_to_hash(uri)
      response['error'].nil?
    end
  end

  def get_storyline_segments_hash(storyline_day)
    moves_access_token.get(
      "/api/v1/user/storyline/daily/#{storyline_day}?trackPoints=true")
      .parsed
      .first['segments']
  end

  def moves_redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/moves/callback'
    uri.query = nil
    uri.to_s
  end
end
