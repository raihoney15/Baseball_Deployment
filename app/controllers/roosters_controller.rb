class RoostersController < ApplicationController
  load_and_authorize_resource
  
    before_action :authenticate_user!, except: %i[ index show]
    before_action :set_rooster, only: %i[ show edit update destroy ]
    before_action :set_team
    before_action :set_tournament

def index
    if current_user.nil?
      @rooster = Rooster.all
    else
      @rooster = Rooster.where(user_id:current_user.id)
    end
end

def show
  @tournament = Tournament.find(params[:tournament_id])
  @team = Team.find(params[:team_id])
  @rooster = @team.roosters.find(params[:id])
  ActiveStorage::Current.url_options = {
      host: request.base_url
    }
end

def new
    @tournament = Tournament.find(params[:tournament_id])
    @team = Team.find(params[:team_id])
    @rooster = Rooster.new
end

def create
  @rooster = current_user.roosters.build(rooster_params.merge(team_id: @team.id).merge(tournament_id: @tournament.id))
  if @rooster.save
    flash[:notice] = "Rooster was successfully created."
    redirect_to tournament_team_path(@tournament, @team)
  else
    render "new"
  end
end

def update
  if @rooster.update(rooster_params)
    flash[:notice] = "Rooster was successfully updated."
    redirect_to tournament_team_rooster_path(@tournament,@team,@rooster)
  else
    render "edit"
  end
end


def destroy
  @rooster.destroy
  flash[:notice] = "Rooster was successfully deleted."
  redirect_to tournament_team_path(@tournament, @team)
end


  private

    def set_rooster
      @rooster = Rooster.find(params[:id])
    end

    def set_team
        @team = Team.find(params[:team_id])
    end

    def set_tournament
        @tournament = Tournament.find(params[:tournament_id])
      end

    def rooster_params
      params.require(:rooster).permit(:name, :jersey_number, :image)
    end

end






















































