class YoutubeService
  def video_info(id)
    params = { part: "snippet,contentDetails,statistics", id: id }

    get_json("youtube/v3/videos", params)
  end


  def playlist_videos_info(id)
    params = { part: 'snippet', playlistId: id }

    get_json('youtube/v3/playlistItems', params)
  end

  def playlist_tutorial_info(id)
    params = { part: 'snippet', id: id }

    get_json('youtube/v3/playlists', params)
  end

  private

  def get_json(_url, params)
    response = conn.get(_url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://www.googleapis.com") do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
