class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show]

  load_and_authorize_resource
    before_action :set_event, only: %i[ show edit update destroy start ]
    before_action :set_tournament


    def start
      @event = Event.find(params[:id])
      @event.update(is_live: true)
      render 'start/show'
    end

def index
binding.pry
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

    def set_event
        @event = Event.find(params[:id])
    end

    def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
    end


    def event_params
      params.require(:event).permit(:game_type,:name,:team_id,:opponent_team_id,:location,:start_date,:belongs ,:memo, :image)

    end


end




