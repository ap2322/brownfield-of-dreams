class Users::InvitationsController < ApplicationController

  def new
  end

  def create
    service = GithubService.new
    json = service.friend_json(invite_params[:github_handle], current_user.token)

    friend = GithubUser.new(json)
    if friend.email
      InvitationMailer.invite(current_user, friend).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to '/dashboard'
  end


  private

  def invite_params
    params.require(:invitation).permit(:github_handle)
  end

end
