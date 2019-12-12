class PlaylistTutorial
  attr_reader :videos, :tutorial

  def initialize(playlist_id)
    @playlist_id = playlist_id
    @tutorial = tutorial
    @videos = tutorial_videos
  end

  def playlist_fetch
    service = YoutubeService.new
    service.playlist_info(@playlist_id)
  end

  def tutorial
    @info ||=playlist_fetch[0]
    Tutorial.create!({
      title: @info[:snippet][:title],
      description: description(@info),
      thumbnail: thumbnail(@info),
      playlist_id: @playlist_id,
      })
  end

  def thumbnail(info)
    default_thumbnail = 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    return default_thumbnail unless info[:snippet][:thumbnail]
    info[:snippet][:thumbnail]
  end

  def description(info)
    return 'Turing Tutorial' unless info[:snippet][:description].length > 0
    info[:snippet][:description]
  end

  def tutorial_videos
    @info[0]
    @tutorial.videos.create()
  end

end
