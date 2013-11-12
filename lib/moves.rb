module Moves
  def moves_client
    OAuth2::Client.new(
      ENV['MOVES_CLIENT_ID'],
      ENV['MOVES_CLIENT_SECRET'],
      :site => 'https://api.moves-app.com',
      :authorize_url => "https://api.moves-app.com/oauth/v1/authorize",
      :token_url => 'https://api.moves-app.com/oauth/v1/access_token')
  end

  def moves_redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/auth/moves/callback'
    uri.query = nil
    uri.to_s
  end

  def moves_access_token
    OAuth2::AccessToken.new(
      moves_client,
      session[:access_token],
      :refresh_token => session[:refresh_token])
  end

  def get_storyline_day_json(storyline_day)
    storyline_json = moves_access_token.get(
      "/api/v1/user/storyline/daily/#{storyline_day}?trackPoints=true")
      .parsed
      .first
  end
end
