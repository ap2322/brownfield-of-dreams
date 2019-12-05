class Users::GithubInfoController < ApplicationController
  def show
    github_info = request.env['omniauth.auth']

    token = github_info[:credentials][:token]
    username = github_info[:info][:nickname]


    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["token"] = token
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("https://api.github.com/users/#{username}/repos")

    repos = JSON.parse(response.body)
    binding.pry



  end
end
