class Admin::PlaylistTutorialsController < ApplicationController
  def new
  end

  def create
    playlist_object = PlaylistObjects.new(playlist_params[:playlist_id])
    tutorial = playlist_object.tutorial
    if tutorial.save
      playlist_object.make_videos
      flash[:success] = "Successfully created tutorial. " +
                        "#{view_context.link_to('View it here', tutorial_url(tutorial))}."
    else
      flash[:error] = 'Unable to create tutorial.'
    end
    redirect_to '/admin/dashboard'
  end

  private

  def playlist_params
    params.require(:playlist_tutorials).permit(:playlist_id)
  end
end
