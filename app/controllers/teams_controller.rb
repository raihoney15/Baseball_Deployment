class TeamsController < ApplicationController
  load_and_authorize_resource
  before_action :set_team, only: %i[ show edit update destroy ]
  before_action :set_tournament


  def index

    if current_user.nil?
      @team = Team.all
    else
      @team = Team.where(user_id:current_user.id)
    end
  end

  def show
    # @team = Team.find(params[:id])
    @tournament = Tournament.find(params[:tournament_id])
    @team = @tournament.teams.find(params[:id])
  end

  def new
    @tournament = Tournament.find(params[:tournament_id])
    @team = Team.new
      
  end

  def edit
    @tournament = Tournament.find(params[:tournament_id])
    @team = @tournament.teams.find(params[:id])
  end

  def create
    # binding.pry
    @team = current_user.teams.build(team_params.merge(tournament_id:@tournament.id ))
    # @team = @tournament.teams.build(team_params)


    respond_to do |format|
      if @team.save
        format.html { redirect_to tournament_team_url(@tournament, @team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location:  @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        # format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.html { redirect_to tournament_team_url(@tournament, @team), notice: "Team was successfully updated." }

        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def set_tournament
      @tournament = Tournament.find(params[:tournament_id])
    end


    def team_params
      params.require(:team).permit(:name, :short_name ) 
    end


end
