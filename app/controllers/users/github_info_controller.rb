class Users::GithubInfoController < ApplicationController
  def show
    github_info = request.env['omniauth.auth']

    token = github_info[:credentials][:token]


    binding.pry
  end
end
