class GithubService
  def repos_as_json(user)
    conn = open_connection("/users/#{user.username}/repos", user.token)
    repos = conn.get("/users/#{user.username}/repos")
    JSON.parse(repos.body)
  end

  private
  def open_connection(url, token)
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["token"] = token
      faraday.adapter Faraday.default_adapter
    end
  end

  # def get_json(_url, params)
  #   response = conn.get("/users/#{username}/repos", params)
  #   JSON.parse(response.body, symbolize_names: true)
  # end

end
