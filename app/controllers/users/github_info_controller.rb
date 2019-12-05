class Users::GithubInfoController < ApplicationController
  def show
    github_info = request.env['omniauth.auth']

    token = github_info[:credentials][:token]
    username = github_info[:info][:nickname]


    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["token"] = token
      faraday.adapter Faraday.default_adapter
    end

    repos = conn.get("/users/#{username}/repos")
    repos_as_json = JSON.parse(repos.body)

    followers = conn.get("/users/#{username}/followers")
    followers_as_json = JSON.parse(followers.body)

    following = conn.get("/users/#{username}/following")
    following_as_json = JSON.parse(following.body)


    binding.pry

  end
end
