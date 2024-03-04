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
      redirect_to root_path, notice: 'Invitation accepted successfully.'
    else
      redirect_to root_path, alert: 'Invitation not found.'
    end
  end
  
  # def accept
  #   @invitation = Invitation.find_by(token: params[:token])
  #   if @invitation
  #     # Update the accepted status of the invitation
  #     @invitation.update(accepted: true)
  #     # Redirect to the recipient's index page
  #     redirect_to user_index_path(@invitation.recipient), notice: 'Invitation accepted successfully.'
  #   else
  #     redirect_to root_path, alert: 'Invitation not found.'
  #   end
  # end
  
  
  def new
    @invitation = Invitation.new
  end

  # def create
  #   @invitation = Invitation.new(invitation_params)
  #   @invitation.sender = current_user
  #   @invitation.generate_token
  #   if @invitation.save
  #     # Send the invitation email
  #     UserMailer.invite(@invitation).deliver_now
  #     redirect_to root_path, notice: 'Invitation sent successfully.'
  #   else
  #     render :new
  #   end
  # end
  

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.tournament = @tournament
    
    if @invitation.save
      
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






