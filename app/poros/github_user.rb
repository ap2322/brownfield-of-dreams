class GithubUser
  attr_reader :handle, :html_url, :name, :email

  @@instances = []

  def initialize(info)
    @name = info['name']
    @handle = info['login']
    @html_url = info['html_url']
    @email = info['email']
    @@instances << self
  end

  def in_db
    User.find_by(username: handle)
  end

  def not_friend?(user_id)
    Friendship.find_by(user_id: user_id, friend_id: in_db.id) == nil
  end

  def self.all
    @@instances.inspect
    # ObjectSpace.each_object(self).to_a
  end

end
