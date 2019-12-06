class Follower
  attr_reader :handle, :html_url

  def initialize(info)
    @handle = info['login']
    @html_url = info['html_url']
  end
end
