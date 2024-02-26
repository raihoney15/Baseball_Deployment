class PlayEventService
  def initialize(event, move_id, current_user)
    @event = event
    @move_id = move_id
    @current_user = current_user
  end

  def call
    move = Move.find(@move_id)
    case move.name
    when "single"
      ChangeRoosterPositionsService.new(@event, "single", @current_user).call
    when "double"
      ChangeRoosterPositionsService.new(@event, "double", @current_user).call
    when "triple"
      ChangeRoosterPositionsService.new(@event, "triple", @current_user).call
    when "out"
      ChangeRoosterPositionsService.new(@event, "out", @current_user).call
    when "strike"
      ChangeRoosterPositionsService.new(@event, "strike", @current_user).call
    when "ball"
      ChangeRoosterPositionsService.new(@event, "ball", @current_user).call
    when "homerun"
      ChangeRoosterPositionsService.new(@event, "homerun", @current_user).call
    end
  end
end
