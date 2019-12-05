class Repository
  attr_reader :name, :html_url

  def initialize(info)
    @name = info["name"]
    @html_url = info["html_url"]
  end
end
