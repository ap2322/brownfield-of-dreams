class Admin::PlaylistTutorialsController < ApplicationController

  def new
  end

  def create
    service = YoutubeService.new
    tutorial_info = service.playlist_tutorial_info(playlist_params[:playlist_id])

    tutorial = Tutorial.new({
      title: tutorial_info[:items][0][:snippet][:title],
      description: description(tutorial_info[:items][0][:snippet][:description]),
      thumbnail: tutorial_info[:items][0][:snippet][:thumbnails][:default][:url],
      playlist_id: playlist_params[:playlist_id]
      })

    if tutorial.save
      make_videos(tutorial)
      binding.pry
      flash[:success] = "Successfully created tutorial."
    end
  end

  def make_videos(tutorial)
    service = YoutubeService.new
    videos_info = service.playlist_videos_info(playlist_params[:playlist_id])
    videos_info[:items].each do |video_info|
      tutorial.videos.create({
        title: video_info[:snippet][:title],
        description: video_info[:snippet][:description],
        thumbnail: video_info[:snippet][:thumbnails][:default][:url],
        video_id: video_info[:snippet][:resourceId][:videoId],
        position: video_info[:snippet][:position]
        })
    end
  end

  private

  def description(info)
    return 'unknown' unless info.length > 0
    info
  end

  def playlist_params
    params.require(:playlist_tutorials).permit(:playlist_id)
  end

end
