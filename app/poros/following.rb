class Following
  attr_reader :handle, :html_url
  include ResourceValidation
  
  def initialize(info)
    @handle = info['login']
    @html_url = info['html_url']
  end
end
