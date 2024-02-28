class UserMailer < ApplicationMailer
  def send_pin(user)
    @user = user
    mail(to: @user.email, subject: 'Verification PIN Code')
  end

  def invite(email, tournament)
    @tournament = tournament
    mail(to: email, subject: 'You have been invited to become a tournament admin')
  end
  # def invite(invitation)
  #   @invitation = invitation
  #   @url = accept_invitation_url(token: @invitation.token)
  #   mail(to: @invitation.recipient_email, subject: 'Invitation to join the tournament')
  # end
end
