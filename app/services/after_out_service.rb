class AfterOutService
  def initialize(event, scoreboard, current_user)
    @event = event
    @scoreboard = scoreboard
    @current_user = current_user
  end

  def call
    
    PitchingStat.create!( 
      pitch: 0,
      event_id: @event.id,
      opponent_team_id: @event.opponent_team_id,
      opponent_rooster_id: @event.opponent_team_line_ups.where(position_id: 2).first.opponent_rooster_id,
      scoreboard_id: @event.scoreboard.last.id
      )
      
      BattingStat.create!(
        event_id: @event.id,
        team_id: @event.team_id,
        rooster_id:@event.team_line_ups.find_by(batter_order: 1).rooster_id,
        scoreboard_id: @event.scoreboard.last.id,        
        run: 0
      )
    # EventInning.create(inning_number: 1, bottom: true, top:false, event_id: @event.id)
    
    scoreboard = Scoreboard.create(balls: 0 ,run: 0, strike: 0, out: 0, event_id: @event.id, event_inning_id: @event.event_innings.last.id, home_team: false,home_away: true)
    team_line_ups = @event.team_line_ups
    first_base_rooster_id = team_line_ups.find_by(batter_order: 1)&.rooster_id

    rooster_position = RoosterPosition.new(scoreboard_id: @event.scoreboard.last.id, user_id: @current_user.id)
    
    @event.opponent_team_line_ups.each do |opponent_team_line_up|
      position_name = Position.find(opponent_team_line_up.position_id).position_name.downcase
      rooster_position.update(position_name.to_sym => opponent_team_line_up.opponent_rooster_id)
      
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




