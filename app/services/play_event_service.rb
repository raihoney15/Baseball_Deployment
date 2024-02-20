class PlayEventService
  def initialize(event, move_id)
    @event = event
    @move_id = move_id
  end

  def call
    move = Move.find(@move_id)
    case move.name
    when "single"
      ChangeRoosterPositionsService.new(@event, "single").call
    when "double"
      ChangeRoosterPositionsService.new(@event, "double").call
    when "triple"
      ChangeRoosterPositionsService.new(@event, "triple").call
    end
  end
end
