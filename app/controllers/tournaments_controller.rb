class TournamentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: %i[ index show]
 
  before_action :set_tournament, only:[ :show, :edit, :update, :destroy ]

  def index
    # binding.pry
    @q = Tournament.ransack(params[:q])
      if current_user.nil?
        @tournaments = @q.result(distinct: true).page(params[:page]).per(5)
      elsif current_user&.roles&.exists?(role_name:'admin')
        @tournaments = @q.result(distinct: true).page(params[:page]).per(5)
      else
        @tournaments = @q.result(distinct: true).where(user_id: current_user.id).page(params[:page]).per(5)
      end
  end

  def show

    ActiveStorage::Current.url_options = {
      host: request.base_url
    }
    @tournament = Tournament.find(params[:id])
    @team = @tournament.teams
    @opponent_team = @tournament.opponent_teams
    @event = @tournament.events
    @q_events = @tournament.events.ransack(params[:q])
    @events = @q_events.result(distinct: true)
    @q_teams = @tournament.teams.ransack(params[:q])
    @teams = @q_teams.result(distinct: true)
  end

  def new
    @tournament = Tournament.new
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  def create
    @tournament = @current_user.tournaments.create(tournament_params)
    if @tournament.save
      redirect_to tournament_path(@tournament)
    else
      render "new"
    end

  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
        redirect_to tournament_path
    else
        render "edit"
    end


  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    redirect_to tournaments_path

  end

  private
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    def tournament_params
      params.require(:tournament).permit(:name, :start_date, :end_date, :location, :user_id, :image)
    end
    

end



