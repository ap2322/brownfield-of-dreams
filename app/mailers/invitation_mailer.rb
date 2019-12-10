class InvitationMailer < ApplicationMailer

  def invite(user, friend)
    @user = user
    @friend = friend
    mail(to: @friend.email, subject: "You're Invited!")
  end

end
