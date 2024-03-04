class OpponentRoostersController < ApplicationController
    before_action :authenticate_user!, except: %i[ index show]
    load_and_authorize_resource
    before_action :set_opponent_rooster, only: %i[ show update destroy ]
    before_action :authenticate_user!, except: %i[ index]
    before_action :set_opponent_team
    before_action :set_tournament

    def new
        @tournament = Tournament.find(params[:tournament_id])
        @opponent_team = OpponentTeam.find(params[:opponent_team_id])
        @opponent_rooster = OpponentRooster.new
    end

def index
    if current_user.nil?
      @opponent_rooster = OpponentRooster.all
    else
      @opponent_rooster = OpponentRooster.where(user_id:current_user.id)
    end
end

def show
    @tournament = Tournament.find(params[:tournament_id])
    @opponent_team = OpponentTeam.find(params[:opponent_team_id])
    @opponent_rooster = @opponent_team.opponent_roosters.find(params[:id])
    ActiveStorage::Current.url_options = {
        host: request.base_url
      }
end



def create
    @opponent_rooster = current_user.opponent_roosters.build(opponent_rooster_params.merge(opponent_team_id:@opponent_team.id ).merge(tournament_id:@tournament.id))
    if @opponent_rooster.save
        redirect_to tournament_opponent_team_path(@tournament,@opponent_team)
    else
        render "new"
    end

end

def update
    if @opponent_rooster.update(opponent_rooster_params)
        redirect_to tournament_opponent_team_path(@tournament,@opponent_team)
    else
        render "edit"
    end
end

def destroy
    @opponent_rooster.destroy
    redirect_to tournament_opponent_team_path(@tournament,@opponent_team)
end

  private

    def set_opponent_rooster
      @opponent_rooster = OpponentRooster.find(params[:id])
    end

    def set_opponent_team
        @opponent_team = OpponentTeam.find(params[:opponent_team_id])
    end

    def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
      end

    def opponent_rooster_params
      params.require(:opponent_rooster).permit(:name, :jersey_number, :image)
   
    end

end

I want to show flash message on creating and updating flashmessage should be shown on opponent_rooster show page on deleting rooster flashmessage should be shown on opponent_team show page.
