class InvitationsController < ApplicationController
  before_action :set_tournament, only: [:new, :create]
  before_action :set_invitation, only: [:accept]



  def accept
    @invitation = Invitation.find(params[:id])
    if @invitation
      user = User.find_by(email: @invitation.email)
      user.assign_tournament_admin_role(@invitation.email) if user
      @invitation.update(accepted: true)
      redirect_to root_path, notice: 'Invitation accepted successfully.'
    else
      redirect_to root_path, alert: 'Invitation not found.'
    end
  end
  
  
  
  
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.tournament = @tournament
    
    if @invitation.save
      binding.pry
      UserMailer.invite(@invitation, @tournament).deliver_now

      redirect_to @tournament, notice: 'Invitation sent successfully.'
    else
      render :new
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def invitation_params
    params.require(:invitation).permit(:email)
  end
end






