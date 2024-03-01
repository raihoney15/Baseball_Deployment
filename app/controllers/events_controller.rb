class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show]

  load_and_authorize_resource
    before_action :find_event_by_id, only: %i[ show edit update destroy start ]
    before_action :set_tournament

  def start
    if @event.is_live?
    else
      StartEventService.new(find_event_by_id, current_user).call
    end

    render 'start'
  end

  def resume
    @event = find_event_by_id
    render 'start'
  end

  def play
    # @commentary = Commentary.new(rooster_name: @rooster.name, move_name: @move.name)
    # @commentary.save
    PlayEventService.new(find_event_by_id, event_params[:move_id],current_user).call
  end

  def index
    @q_events = Event.ransack(params[:q])
    if current_user.nil?
      @event =  @q_events.result(distinct: true).all
    else
      @event =  @q_events.result(distinct: true).where(user_id:current_user.id)
    end
  end

  def show
    @tournament = Tournament.find(params[:tournament_id])
    @event = @tournament.events.find(params[:id]) 
  end

  def new
    @tournament = Tournament.find(params[:tournament_id])
    @event = Event.new
  end

  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @event = @tournament.events.find(params[:id])
  end

  def create
    @event = current_user.events.build(event_params.merge(tournament_id:@tournament.id ))
    if @event.save
      redirect_to tournament_event_path(@tournament, @event)
    else
      render "new"
    end
  end

  def update
    if @event.update(event_params)
      redirect_to tournament_event_path(@tournament, @event)
    else
      render "edit"
    end
  end

  def destroy
    @team.destroy
    redirect_to tournament_teams_path
  end

  private
    def find_event_by_id
      Event.find(params[:id])
    end

    def set_tournament
      @tournament = Tournament.find(params[:tournament_id])
    end

    def event_params
      params.require(:event).permit(:game_type,:name,:team_id,:opponent_team_id,:location,:start_date,:belongs ,:memo, :image, :move_id)
    end
end
