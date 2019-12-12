class PlaylistObjects
  attr_reader :tutorial

  def initialize(playlist_id)
    @playlist_id = playlist_id
    @tutorial = make_tutorial
  end

  def tutorial_info
    service = YoutubeService.new

    service.playlist_tutorial_info(@playlist_id)
  end

  def make_tutorial
    @tutorial_info ||= tutorial_info
    Tutorial.new({  title: @tutorial_info[:items][0][:snippet][:title],
                    description: description(@tutorial_info[:items][0][:snippet][:description]),
                    thumbnail: @tutorial_info[:items][0][:snippet][:thumbnails][:default][:url],
                    playlist_id: @playlist_id })
  end

  def description(info)
    return 'unknown' unless info.length > 0

    info
  end

  def videos_info
    service = YoutubeService.new

    service.playlist_videos_info(@playlist_id)
  end

  def make_videos
    videos_info[:items].each do |video_info|
      @tutorial.videos.create({ title: video_info[:snippet][:title],
                                description: video_info[:snippet][:description],
                                thumbnail: video_info[:snippet][:thumbnails][:default][:url],
                                video_id: video_info[:snippet][:resourceId][:videoId],
                                position: @playlist_id })
    end
  end
end
