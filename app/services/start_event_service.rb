class StartEventService
  def initialize(find_event_by_id, current_user)
    @event = find_event_by_id
    @current_user = current_user
  end

  def call
    
    @event.update(is_live: true)
    
    EventSetup.find_or_create_by(inning_rounds: 9, event_id: @event.id)
    
    EventInning.find_or_create_by!(inning_number: 1, top: true, event_id: @event.id)
    scoreboard = Scoreboard.find_or_create_by(balls: 0,run: 0, strike: 0, out: 0, event_id: @event.id, event_inning_id: @event.event_innings.last.id, home_team: true)
    UpdateRoosterPositionsService.new(@event, scoreboard, @current_user).call
  end
end

