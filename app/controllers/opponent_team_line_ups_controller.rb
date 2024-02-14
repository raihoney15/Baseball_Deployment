
class OpponentTeamLineUpsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: %i[ index show]
  before_action :set_opponent_team_line_up, only: [:show, :update, :destroy]
  before_action :set_tournament
  before_action :set_event

  def new
    @opponent_team_line_up = OpponentTeamLineUp.new
    a = @event.opponent_team.opponent_roosters.pluck(:id)
    b = @event.opponent_team_line_ups.pluck(:opponent_rooster_id)
    final1 = a - b
    @final1 =  OpponentRooster.find(final1)
  end

  def index

  end

  def show

  end

  def create
    binding.pry
    @opponent_team_line_up = current_user.opponent_team_line_ups.build(opponent_team_line_up_params.merge(event_id: @event.id, tournament_id: @tournament.id, opponent_team_id: @opponent_team_id))

    if @opponent_team_line_up.save
      redirect_to new_tournament_event_opponent_team_line_up_path, notice: 'Opponent Team lineup was successfully created.'
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
