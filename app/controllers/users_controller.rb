class UsersController < Clearance::UsersController
  include Moves

  before_filter :authorize

  def edit
    @user = current_user
    @moves_authorize_uri = moves_client.auth_code.authorize_url(
      :redirect_uri => moves_redirect_uri,
      :scope => 'activity location')

    render :template => 'users/edit'
  end
end
