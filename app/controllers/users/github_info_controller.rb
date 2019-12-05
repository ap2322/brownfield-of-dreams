class Users::GithubInfoController < ApplicationController
  def show
    github_info = request.env['omniauth.auth']
    user = current_user

    facade = GithubInfoFacade.new(github_info, user)

    # want an array of objects for repos, followers, and following
    repos = facade.repos
    # followers = facade.followers
    # followers = facade.following
    # declaring what we wish existed
    render 'users/show', locals: {
      github_info_for_user: GithubInfoFacade.new(github_info, user)
    }


    #
    # github_info = request.env['omniauth.auth']
    # token = github_info[:credentials][:token]
    # username = github_info[:info][:nickname]
    #
    # user.username = username
    # user.uid      = github_info[:uid]
    # user.token    = token
    # user.save
    #
    #
    #
    # conn = Faraday.new(url: "https://api.github.com") do |faraday|
    #   faraday.headers["token"] = token
    #   faraday.adapter Faraday.default_adapter
    # end
    #
    # repos = conn.get("/users/#{username}/repos")
    # repos_as_json = JSON.parse(repos.body)
    #
    # followers = conn.get("/users/#{username}/followers")
    # followers_as_json = JSON.parse(followers.body)
    #
    # following = conn.get("/users/#{username}/following")
    # following_as_json = JSON.parse(following.body)

  end
end
