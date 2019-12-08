class ActivationMailer < ApplicationMailer

  def activate
    @user = current_user
    mail(to: @user.email, subject: 'Turing Tutorials Account Activation')
  end
end
