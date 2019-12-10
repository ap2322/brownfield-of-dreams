class UserFacade < SimpleDelegator
  def initialize(user)
    super(user)
  end

  def tutorial_user_video_hash
    user_videos.tutorial_sort.each_with_object({}) do |user_video, hash|
      hash[user_video.tutorial_title] ||= []
      hash[user_video.tutorial_title] << user_video
    end
  end

  def repos
    service = GithubService.new
    @repos ||= service.repos_json(token)

    @repos.map do |repo|
      Repository.new(repo)
    end[0..4]
  end

  def followers
    service = GithubService.new
    @followers ||= service.followers_json(token)

    @followers.map do |follower|
      GithubUser.new(follower)
    end
  end

  def followings
    service = GithubService.new
    @followings ||= service.followings_json(token)

    @followings.map do |following|
      GithubUser.new(following)
    end
  end
end
