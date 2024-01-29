class TournamentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_tournament, only: %i[ show edit update destroy ]

  def index
    if current_user.nil?
      @tournament = Tournament.all
    else
       @tournament = Tournament.where(user_id:current_user.id)
    end
    
  end


  def show
    @tournament = Tournament.find(params[:id])
    @team = @tournament.teams
  end

  def new
    @tournament = Tournament.new
  end

  def edit
  end

  def create

    respond_to do |format|
      if @tournament.save
        format.html { redirect_to tournament_url(@tournament), notice: "Tournament was successfully created." }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tournament.update(tournament_params)
        format.html { redirect_to tournament_url(@tournament), notice: "Tournament was successfully updated." }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tournament.destroy!

    respond_to do |format|
      format.html { redirect_to tournaments_url, notice: "Tournament was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end
    def tournament_params
      params.require(:tournament).permit(:name, :start_date, :end_date, :location)
    end
end
