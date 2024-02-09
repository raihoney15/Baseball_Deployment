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
    end

    def index

    end

    def show

    end

    def create
      @team_line_up = current_user.team_line_ups.build(team_line_up_params.merge(event_id: @event.id, tournament_id: @tournament.id, team_id: @team_id))
  
      if @team_line_up.save
        redirect_to tournament_event_path(@tournament, @event)
      else
        render :new
      end
    end        
        # def create
        #   position_rooster = team_line_up_params[:position_rooster]
         
        #   if position_rooster.present?
        #     position_rooster.each do |position_id, rooster_id|
        #       @team_line_up = current_user.team_line_ups.build(
        #         batter_order: team_line_up_params[:batter_order],
        #         rooster_id: rooster_id,
        #         position_id: position_id,
        #         event_id: @event.id,
        #         tournament_id: @tournament.id,
        #         team_id: @team_id
        #       )
        
        #       if  @team_line_up.save
        #         redirect_to tournament_event_path(@tournament, @event)
        #       else 
        #         render :new
        #       end

        #     end
        #   end
        # end
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

