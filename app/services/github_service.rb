class GithubService
  def repos_json(token)
    connection = conn(token)
    repos = connection.get("/user/repos")
    JSON.parse(repos.body)
  end

  private
  def conn(token)
    Faraday.new(url:"https://api.github.com") do |f|
      f.params['access_token'] = token
      f.adapter Faraday.default_adapter
    end
  end

end
