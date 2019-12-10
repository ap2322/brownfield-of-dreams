class GithubService
  def repos_json(token)
    connection = conn(token)
    repos = connection.get("/user/repos")
    JSON.parse(repos.body)
  end

  def followers_json(token)
    connection = conn(token)
    followers = connection.get("/user/followers")
    JSON.parse(followers.body)
  end

  def followings_json(token)
    connection = conn(token)
    followings = connection.get("/user/following")
    JSON.parse(followings.body)
  end

  def friend_json(handle, token)
    connection = conn(token)
    friend = connection.get("/users/#{handle}")

    JSON.parse(friend.body)
  end

  private

  def conn(token)
    Faraday.new(url: "https://api.github.com") do |f|
      f.params['access_token'] = token
      f.adapter Faraday.default_adapter
    end
  end
end
