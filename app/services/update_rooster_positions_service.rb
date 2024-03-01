class UpdateRoosterPositionsService
  def initialize(event, scoreboard, current_user)
    @event = event
    @scoreboard = scoreboard
    @current_user_id = current_user
  end

  def call
    
    PitchingStat.find_or_create_by!( 
      pitch: 0,
      event_id: @event.id,
      team_id: @event.team_id,
      rooster_id: @event.team_line_ups.where(position_id: 2).first.rooster_id,
      scoreboard_id: @event.scoreboards.last.id
      )
      
      BattingStat.find_or_create_by!(
        event_id: @event.id,
        opponent_team_id: @event.opponent_team_id,
        opponent_rooster_id:@event.opponent_team_line_ups.find_by(batter_order: 1).opponent_rooster_id,
        scoreboard_id: @event.scoreboards.last.id,
        run: 0
      )
      
    opponent_team_line_ups = @event.opponent_team_line_ups
    first_base_rooster_id = opponent_team_line_ups.find_by(batter_order: 1)&.opponent_rooster_id


      @event.team_line_ups.each do |team_line_up|
        rooster_position = RoosterPosition.find_or_create_by(scoreboard_id: @scoreboard.id, user_id: @current_user_id.id)
  
        position_name = Position.find(team_line_up.position_id).position_name.downcase
        rooster_position.update(position_name.to_sym => team_line_up.rooster_id)
  
        if position_name == "first_base"
          rooster_position.update(first_base: first_base_rooster_id)
        elsif position_name == "second_base"
          rooster_position.update(second_base: nil)
        elsif position_name == "third_base"
          rooster_position.update(third_base: nil)
        elsif position_name == "fourth_base"
          rooster_position.update(fourth_base: nil)
        end
      end
  end
end
  



