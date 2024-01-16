class RoostersController < ApplicationController
  before_action :set_rooster, only: %i[ show edit update destroy ]

  # GET /roosters or /roosters.json
  def index
    @roosters = Rooster.all
  end

  # GET /roosters/1 or /roosters/1.json
  def show
  end

  # GET /roosters/new
  def new
    @rooster = Rooster.new
  end

  # GET /roosters/1/edit
  def edit
  end

  # POST /roosters or /roosters.json
  def create
    @rooster = Rooster.new(rooster_params)

    respond_to do |format|
      if @rooster.save
        format.html { redirect_to rooster_url(@rooster), notice: "Rooster was successfully created." }
        format.json { render :show, status: :created, location: @rooster }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rooster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roosters/1 or /roosters/1.json
  def update
    respond_to do |format|
      if @rooster.update(rooster_params)
        format.html { redirect_to rooster_url(@rooster), notice: "Rooster was successfully updated." }
        format.json { render :show, status: :ok, location: @rooster }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rooster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roosters/1 or /roosters/1.json
  def destroy
    @rooster.destroy!

    respond_to do |format|
      format.html { redirect_to roosters_url, notice: "Rooster was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rooster
      @rooster = Rooster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rooster_params
      params.require(:rooster).permit(:name, :jersey_number)
    end
end
