class User::GithubInfoController < ApplicationController

  def show
    info = request.env['omniauth.auth']
    current_user.update_attribute(:token, info[:credentials][:token])
    current_user.update_attribute(:username, info[:info][:nickname])
    current_user.update_attribute(:github_id, info[:uid])
    redirect_to '/dashboard'
  end

end
