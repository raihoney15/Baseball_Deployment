class TournamentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_tournament, only:[ :show, :edit, :update, :destroy ]

  def index
    if current_user.nil?
      @tournament = Tournament.all.page(params[:page]).per(3)
    else
       @tournament = Tournament.where(user_id:current_user.id).page(params[:page]).per(3)
    end
  end


  def show
    @tournament = Tournament.find(params[:id])
    @team = @tournament.teams
    @opponent_team = @tournament.opponent_teams
  end

  def new
    # binding.pry
    @tournament = Tournament.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = @current_user.tournaments.create(tournament_params)
    if @tournament.save
      redirect_to tournament_path(@tournament)
    else
      render "new"
    end

  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
        redirect_to tournament_path
    else
        render "edit"
    end


  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    redirect_to tournaments_path

  end

  private
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end
    def tournament_params
      params.require(:tournament).permit(:name, :start_date, :end_date, :location, :user_id)
    end



end