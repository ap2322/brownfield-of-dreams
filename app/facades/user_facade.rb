class UserFacade < SimpleDelegator

  def initialize(user)
    super(user)
  end

  def repos
    service = GithubService.new
    @repos ||= service.repos_json(token)

    @repos.map do |repo|
      Repository.new(repo)
    end
  end

  def followers
    service = GithubService.new
    @followers ||= service.followers_json(token)

    @followers.map do |follower|
      Follower.new(follower)
    end
  end

  def following
    service = GithubService.new
    @following ||= service.following_json(token)

    @following.map do |following|
      Following.new(following)
    end
  end



end
