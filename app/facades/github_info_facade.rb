class GithubInfoFacade
  def initialize(github_info_hash, user)
    @github_info = github_info_hash
    @user = user
    update_user_info
  end

  def update_user_info
    user.username = github_info[:info][:nickname]
    user.uid      = github_info[:uid]
    user.token    = github_info[:credentials][:token]
    user.save
  end

  def repos
    service = GithubService.new
    @repos ||= service.repos_as_json(user)

    @repos.map do |repo_info|
      Repository.new(repo_info)
    end
  end

  def five_repos
    repos[0..4]
  end

  def followers

  end

  def following

  end

  private
  attr_reader :github_info, :user
end
