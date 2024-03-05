class InvitationsController < ApplicationController
  before_action :set_tournament, only: [:new, :create]
  before_action :set_invitation, only: [:accept]
  before_action :authenticate_user!


  def accept
    @invitation = Invitation.find(params[:id])
    if @invitation
      
      user = User.find_by(email: @invitation.email)
      user.assign_tournament_admin_role(@invitation.email) if user
      @invitation.update(accepted: true)
      redirect_to root_path
    else
      flash[:alert] = "Invitation not found."
      redirect_to root_path
    end
  end

  
  def new
    @invitation = Invitation.new
  end


  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.tournament = @tournament
    
    if @invitation.save
      
      UserMailer.invite(@invitation, @tournament).deliver_now
      flash[:success] = "Invitation sent Successfully."
      redirect_to @tournament
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






