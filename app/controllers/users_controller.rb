class UsersController < Clearance::UsersController
  include Moves
  include Instagram

  before_filter :authorize, only: [:edit]

  def edit
    @moves_authorize_uri = moves_client.auth_code.authorize_url(
      :redirect_uri => moves_redirect_uri,
      :scope => 'activity location')

    @instagram_authorize_uri = instagram_client.auth_code.authorize_url(
      :redirect_uri => instagram_redirect_uri)

    render :template => 'users/edit'
  end
end
