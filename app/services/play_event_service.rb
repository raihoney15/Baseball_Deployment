class PlayEventService
  def initialize(event, move_id, current_user)
    @event = event
    @move_id = move_id
    @current_user = current_user
    @call_from_service = true
  end

  def call
    move = Move.find(@move_id)
    case move.name
    when "single"
      ChangeRoosterPositionsService.new(@event, "single", @current_user, scoreboard).call
    when "double"
      ChangeRoosterPositionsService.new(@event, "double", @current_user, scoreboard).call
    when "triple"
      ChangeRoosterPositionsService.new(@event, "triple", @current_user, scoreboard).call
    when "out"
      ChangeRoosterPositionsService.new(@event, "out", @current_user, scoreboard).call
    end
  end
end
