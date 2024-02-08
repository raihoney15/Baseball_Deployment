
class OpponentTeamLineUpsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index]

  before_action :set_opponent_team_line_up, only: [:show, :update, :destroy]
  before_action :set_tournament
  before_action :set_event

  def new
    @opponent_team_line_up = OpponentTeamLineUp.new
  end

  def index

  end

  def show

  end

  def create
    @opponent_team_line_up = current_user.opponent_team_line_ups.build(opponent_team_line_up_params.merge(event_id: @event.id, tournament_id: @tournament.id, opponent_team_id: @opponent_team_id))

    if @opponent_team_line_up.save
      redirect_to tournament_event_path(@tournament, @event)
    else
      render :new
    end
  end

  def update

  end

  def destroy

  end

  private

  def set_opponent_team_line_up
    @opponent_team_line_up = OpponentTeamLineUp.find(params[:id])
  end

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_event
    @event = Event.find(params[:event_id])
    @opponent_team_id = @event.opponent_team_id
  end

  def opponent_team_line_up_params
    params.require(:opponent_team_line_up).permit(:batter_order, :opponent_rooster_id, :position_id)
  end
end
