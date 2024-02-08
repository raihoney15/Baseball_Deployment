class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index]

    before_action :set_event, only: %i[ show edit update destroy ]
    before_action :set_tournament


def index
    if current_user.nil?
      @event = Event.all
    else
      @event = Event.where(user_id:current_user.id)
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
