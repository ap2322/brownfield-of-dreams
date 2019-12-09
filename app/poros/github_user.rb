class GithubUser
  attr_reader :handle, :html_url

  def initialize(info)
    @handle = info['login']
    @html_url = info['html_url']
  end

  def in_db
    User.find_by(username: handle )
  end

  def not_friend?(user_id)
    Friendship.find_by(user_id: user_id, friend_id: in_db.id) == nil
  end
end
