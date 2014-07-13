class InstagramController < ApplicationController
  include Instagram

  def callback
    new_token = instagram_client.auth_code.get_token(
      params[:code],
      :redirect_uri => instagram_redirect_uri)
    current_user.update_attribute(:instagram_access_token, new_token.token)
    current_user.update_attribute(:instagram_user_id, new_token['user']['id'])
    redirect_to root_url
  end

  def destroy
    current_user.update_attribute(:instagram_access_token, nil)
    current_user.update_attribute(:instagram_user_id, nil)
    redirect_to root_url
  end
end
