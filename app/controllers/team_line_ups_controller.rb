class TeamLineUpsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: %i[ index show]
    before_action :set_team_line_up, only: [:show, :edit, :update, :destroy]
    before_action :set_tournament
    before_action :set_event


    def new
        @tournament = Tournament.find(params[:tournament_id])
        @event = Event.find(params[:event_id])
        @team_line_up = TeamLineUp.new   
        a = @event.team.roosters.pluck(:id)
        b = @event.team_line_ups.pluck(:rooster_id)
        final = a - b
        @final =  Rooster.find(final)

        all_positions = Position.all.pluck(:id)
        selected_positions = @event.team_line_ups.pluck(:position_id)
        available_positions = all_positions - selected_positions
        @available_positions = Position.find(available_positions)
        
    end


    def index
      all_positions = Position.all.pluck(:id)
      selected_positions = @event.team_line_ups.pluck(:position_id)
      available_positions = all_positions - selected_positions
      @available_positions = Position.find(available_positions)
    end

    def show

      @tournament = Tournament.find(params[:tournament_id])
      @event = Event.find(params[:event_id])
      @team_line_up = TeamLineUp.find(params[:id])
       
    end

    def create

      @team_line_up = current_user.team_line_ups.build(team_line_up_params.merge(event_id: @event.id, tournament_id: @tournament.id, team_id: @team_id))
      if @team_line_up.save
        redirect_to new_tournament_event_team_line_up_path ,notice: 'Team lineup was successfully created.'
      else
        render :new
      end
    end


    def update

    end

    def destroy

    end
    private


    def set_team_line_up
        @team_line_up = TeamLineUp.find(params[:id])
      end
    
      def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
      end
    
      def set_event
        @event = Event.find(params[:event_id])
        @team_id = @event.team_id
      end
          
      def team_line_up_params
        params.require(:team_line_up).permit(:batter_order,:position_id, :rooster_id)
      end

      
end










