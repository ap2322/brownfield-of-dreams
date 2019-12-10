class Users::GithubInfoController < ApplicationController
  def show
    update_user(request.env['omniauth.auth'])
    redirect_to '/dashboard'
  end

  private

  def update_user(info)
    current_user.update_attribute(:token, info[:credentials][:token])
    current_user.update_attribute(:username, info[:info][:nickname])
    current_user.update_attribute(:github_id, info[:uid])
    current_user.update_attribute(:github_name, info[:info][:name])
  end
end
