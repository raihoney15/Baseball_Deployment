class OpponentTeamsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: %i[ index show]
  before_action :set_opponent_team, only: %i[ show edit update destroy ]
  before_action :set_tournament

  def index
    if current_user.nil?
      @opponent_opponent_team  = OpponentTeam .all
    else
      @opponent_team  = OpponentTeam.where(user_id:current_user.id)
    end
  end

  def show
    @tournament = Tournament.find(params[:tournament_id]) 
    @opponent_team = @tournament.opponent_teams.find(params[:id]) 
  end

  def new
    @tournament = Tournament.find(params[:tournament_id])
    @opponent_team = OpponentTeam.new
  end

  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @opponent_team = @tournament.opponent_teams.find(params[:id])
  end

  def create
    @opponent_team = current_user.opponent_teams.build(opponent_team_params.merge(tournament_id:@tournament.id ))
    if @opponent_team.save
      flash[:notice] = "Opponent Team was successfully created."
      redirect_to tournament_opponent_team_path(@tournament, @opponent_team)
    else
      render "new"
    end
  end

  def update
    if @team.update(opponent_team_params)
      flash[:notice] = "Opponent Team was successfully updated."
      redirect_to tournament_opponent_team_path(@tournament, @opponent_team)
    else
      render "edit"
    end
  end

  def destroy
    @opponent_team.destroy
    flash[:notice] = "Opponent Team was successfully deleted."
    redirect_to tournament_opponent_teams_path
  end

  private
    def set_opponent_team
      @opponent_team = OpponentTeam.find(params[:id])
    end

    def set_tournament
      @tournament = Tournament.find(params[:tournament_id])
    end

    def opponent_team_params
      params.require(:opponent_team).permit(:name, :short_name,:user_id,:tournament_id ,:team_id, :image) 
    end
end
