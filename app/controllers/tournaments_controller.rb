class TournamentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, except: %i[ index show]
 
  before_action :set_tournament, only:[ :show, :edit, :update, :destroy ]

  def index
    @q = Tournament.ransack(params[:q])
    if current_user.nil?
      @tournaments = @q.result(distinct: true).page(params[:page]).per(5)
    elsif current_user&.roles&.exists?(role_name:'admin')
      @tournaments = @q.result(distinct: true).page(params[:page]).per(5)
    else
      user_tournaments = current_user.tournaments
      invited_tournaments = Tournament.joins(:invitations).where(invitations: { email: current_user.email, accepted: true })
      @tournaments = (user_tournaments + invited_tournaments).uniq
      @tournaments = @q.result(distinct: true).where(id: @tournaments.map(&:id)).page(params[:page]).per(5)
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
      flash[:success] = "Tournament was successfully created."
      redirect_to tournaments_path
    else
      render "new"
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update(tournament_params)
      flash[:success] = "Tournament was successfully updated."
      redirect_to tournament_path
    else
      render "edit"
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    flash[:success] = "Tournament was successfully deleted."
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


class Tournament < ApplicationRecord
  paginates_per 5

  belongs_to :user, :optional => true
  has_one_attached :image ,dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :opponent_teams, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :team_line_ups, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :opponent_team_line_ups, dependent: :destroy
  validates :name, :start_date, :end_date, :location, presence: true
  validates_presence_of :start_date, :end_date

  validate :end_date_is_after_start_date
  validate :start_date_cannot_be_in_the_past
  validate :name_and_location_cannot_start_with_numbers

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date.past?
      errors.add(:start_date, " can't be in the past")
    end
  end

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, " cannot be before the start date")
    end
  end

  def name_and_location_cannot_start_with_numbers
    if name.present? && name.match?(/\A\d/)
      
      errors.add(:name, " cannot start with a number")
    end

    if location.present? && location.match?(/\A\d/)
      errors.add(:location, " cannot start with a number")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end


I want to to testing for this controller and model. using rspec gem .give me line by line code for that.