class MovesController < ApplicationController
  include Moves

  def callback
    new_token = moves_client.auth_code.get_token(
      params[:code],
      :redirect_uri => moves_redirect_uri)
    current_user.update_attribute(:moves_access_token, new_token.token)
    redirect_to root_url
  end

  def destroy
    current_user.update_attribute(:moves_access_token, nil)
    redirect_to root_url
  end
end

