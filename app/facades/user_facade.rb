class UserFacade < SimpleDelegator
  def initialize(user)
    super(user)
  end

  def repos
    service = GithubService.new
    @repos ||= service.repos_json(token)

    @repos.map do |repo|
      Repository.new(repo)
    end[0..4]
  end

end
