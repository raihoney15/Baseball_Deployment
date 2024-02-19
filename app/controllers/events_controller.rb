class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show]

  load_and_authorize_resource
    before_action :set_event, only: %i[ show edit update destroy start ]
    before_action :set_tournament


    def start
      @event = Event.find(params[:id])
      @event.update(is_live: true)
      EventSetup.create(inning_rounds: 9, event_id: @event.id)
      EventInning.create(inning_number: 1, top: true, event_id: @event.id)
     
      scoreboard = Scoreboard.create(event_id: @event.id, event_inning_id: @event.event_innings.last.id, home_team: true)
      update_rooster_positions(scoreboard)


      render 'start'
    end

    # def play
    #   @event = Event.find(params[:id])
    #   move = Move.find(params[:move_id])
    #   case move.name
    #         when "single"
    #           binding.pry
    #           change_rooster_positions(@event, "single")          
    #         end
    # end

    def play
      @event = Event.find(params[:id])
      move = Move.find(event_params[:move_id])
      case move.name
        when "single"
          change_rooster_positions(@event, "single")          
      end
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

    def set_event
        @event = Event.find(params[:id])
    end

    def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
    end


    # def event_params
    #   params.require(:event).permit(:game_type,:name,:team_id,:opponent_team_id,:location,:start_date,:belongs ,:memo, :image)
    # end
    
    def event_params
      params.require(:event).permit(:game_type,:name,:team_id,:opponent_team_id,:location,:start_date,:belongs ,:memo, :image, :move_id)
    end
    

    def update_rooster_positions(scoreboard)
      @event.team_line_ups.each do |team_line_up|
        rooster_position = RoosterPosition.find_or_create_by(scoreboard_id: scoreboard.id, user_id: current_user.id)
    
        position_name = Position.find(team_line_up.position_id).position_name.downcase
        rooster_position.update(position_name.to_sym => team_line_up.rooster_id)
      end
    end
    
    def change_rooster_positions(event, move_name)
      rooster_positions = RoosterPosition.where(scoreboard_id: event.scoreboard.id)
      case move_name
      when "single"
        rooster_positions.update(second_base: rooster_positions.first.first_base)
        rooster_positions.update(third_base: rooster_positions.first.second_base)
        rooster_positions.update(fourth_base: rooster_positions.first.third_base)
        rooster_positions.update(first_base: rooster_positions.first.fourth_base)
      # when "double"
    
      end
    end

end





























