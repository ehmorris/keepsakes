class MovesController < ApplicationController
  include Moves

  def callback
    new_token = moves_client.auth_code.get_token(
      params[:code],
      :redirect_uri => moves_redirect_uri)
    session[:access_token] = new_token.token
    redirect_to root_url
  end

  def destroy
    session[:access_token] = nil
    redirect_to root_url
  end
end

