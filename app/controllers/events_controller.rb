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
      scoreboard = Scoreboard.create(balls: 0,hit: 0,run: 0,strike: 0, out: 0, event_id: @event.id, event_inning_id: @event.event_innings.last.id, home_team: true)
      update_rooster_positions(scoreboard)
      render 'start'
    end

    def resume
      @event = Event.find(params[:id])
      render 'start'
    end

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

    
    def event_params
      params.require(:event).permit(:game_type,:name,:team_id,:opponent_team_id,:location,:start_date,:belongs ,:memo, :image, :move_id)
    end


    def update_rooster_positions(scoreboard)
      opponent_team_line_ups = @event.opponent_team_line_ups
      first_base_rooster_id = opponent_team_line_ups.find_by(batter_order: 1)&.opponent_rooster_id
    
      @event.team_line_ups.each do |team_line_up|
        rooster_position = RoosterPosition.find_or_create_by(scoreboard_id: scoreboard.id, user_id: current_user.id)
    
        position_name = Position.find(team_line_up.position_id).position_name.downcase
        rooster_position.update(position_name.to_sym => team_line_up.rooster_id)
    
        if position_name == "first_base"
          rooster_position.update(first_base: first_base_rooster_id)
        elsif position_name == "second_base"
          rooster_position.update(second_base: nil)
        elsif position_name == "third_base"
          rooster_position.update(third_base: nil)
        elsif position_name == "fourth_base"
          rooster_position.update(fourth_base: nil)
        else
        end
      end
    end


    def change_rooster_positions(event, move_name)
      rooster_positions = RoosterPosition.where(scoreboard_id: event.scoreboard.id)
      binding.pry
      rooster_position = rooster_positions.first
      puts "Rooster Position: #{rooster_position.inspect}"
      return unless rooster_position
      binding.pry
      case move_name
      when "single"
        new_rooster_position = RoosterPosition.new(
          rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
        )
        new_rooster_position.second_base = rooster_position.first_base
        new_rooster_position.third_base = rooster_position.second_base
        new_rooster_position.fourth_base = rooster_position.third_base
        new_rooster_position.first_base = rooster_position.fourth_base
        new_rooster_position.save
      end
    end
    

end
