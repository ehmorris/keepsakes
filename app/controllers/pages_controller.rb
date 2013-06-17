class PagesController < HighVoltage::PagesController
  def show
    moves_client = OAuth2::Client.new(
      MOVES_ID,
      MOVES_SECRET,
      :site => 'https://api.moves-app.com',
      :authorize_url => 'moves://app/authorize',
      :token_url => 'https://api.moves-app.com/oauth/v1/access_token'
    )
  end
end
