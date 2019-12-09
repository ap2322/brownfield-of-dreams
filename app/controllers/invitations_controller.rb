class InvitationsController < ApplicationController

  def new
  end

  def create
    # FIND PERSON ON GITHUB AND CHECK FOR GITHUB EMAIL
    if friend.email != nil
      InvitationMailer.new(current_user, friend)
      flash[:success] = "Successfully sent invite!"
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
