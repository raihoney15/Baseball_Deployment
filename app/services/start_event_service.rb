class StartEventService
  def initialize(event, current_user)
    @event = event
    @current_user = current_user
  end

  def call
    @event.update(is_live: true)
    EventSetup.create(inning_rounds: 9, event_id: @event.id)
    EventInning.create(inning_number: 1, top: true, event_id: @event.id)
    scoreboard = Scoreboard.create(balls: 0, hit: 0, run: 0, strike: 0, out: 0, event_id: @event.id, event_inning_id: @event.event_innings.last.id, home_team: true)
    UpdateRoosterPositionsService.new(@event, scoreboard, @current_user).call
  end
end
