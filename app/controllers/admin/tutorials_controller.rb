class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if playlist_tutorial_params[:playlist_id]
      tutorial = PlaylistTutorial.new(playlist_tutorial_params[:playlist_id])
    else


      @tutorial = Tutorial.new(tutorial_params)
      if @tutorial.save
        flash[:success] = 'Successfully created tutorial.'
        @tutorial.videos.create(video_params['0'])
        redirect_to "/tutorials/#{@tutorial.id}"
      else
        flash[:error] = @tutorial.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  def new
    @tutorial = Tutorial.new
    1.times { @tutorial.videos.build }
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail, video_attributes: [:video_id])
  end

  def video_params
    params.require(:tutorial).require(:videos_attributes).permit(Video.column_names)
  end

  def playlist_tutorial_params
    params.require(:tutorial).permit(:playlist_id)
  end
end
