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
    @rooster_position = RoosterPosition.find_by(scoreboard_id: @event.scoreboards.last.id)

    render 'start'
  end

  def resume
    @event = find_event_by_id
    render 'start'
  end

  def play

      PlayEventService.new(find_event_by_id, event_params[:move_id],current_user).call
      redirect_to start_tournament_event_path(@tournament, @event)
    
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
    @team_line_ups = @event.team_line_ups
    @opponent_team_line_ups = @event.opponent_team_line_ups
    total_positions = Position.count
    team_line_up_positions_filled = @team_line_ups.pluck(:position_id).uniq.count
    opponent_team_line_up_positions_filled = @opponent_team_line_ups.pluck(:position_id).uniq.count
    if team_line_up_positions_filled == total_positions && opponent_team_line_up_positions_filled == total_positions
      @show_start_button = true
    else
      @show_start_button = false
    end
  
    if @event.is_live.present?
      @show_resume_button = true
    else
      @show_resume_button = false
    end
  
    flash.now[:notice] = flash[:notice] if flash[:notice].present?
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
    @event = current_user.events.build(event_params.merge(tournament_id: @tournament.id))
    if @event.save
      flash[:notice] = "Event was successfully created."
      redirect_to tournament_event_path(@tournament, @event)
    else
      render "new"
    end
  end
  

  def update
    if @event.update(event_params)
      flash[:notice] = "Event was successfully updated."
      redirect_to tournament_event_path(@tournament, @event)
    else
      render "edit"
    end
  end
  

  def destroy
    @event.destroy
    flash[:notice] = "Event was successfully deleted."
    redirect_to tournament_path(@tournament)
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

