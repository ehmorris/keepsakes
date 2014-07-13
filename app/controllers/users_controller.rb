class UsersController < Clearance::UsersController
  include Moves
  include Instagram

  before_filter :authorize, only: [:edit]

  def edit
    @user = current_user
    @moves_is_connected = valid_moves_access_token?(@user.moves_access_token)
    @moves_authorize_uri = moves_client.auth_code.authorize_url(
      :redirect_uri => moves_redirect_uri,
      :scope => 'activity location')

    @instagram_is_connected = valid_instagram_access_token?(@user.instagram_access_token)
    @instagram_authorize_uri = instagram_client.auth_code.authorize_url(
      :redirect_uri => instagram_redirect_uri)

    render :template => 'users/edit'
  end
end
