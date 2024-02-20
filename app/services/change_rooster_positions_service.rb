
  class ChangeRoosterPositionsService
    def initialize(event, move_name)
      @event = event
      @move_name = move_name
    end
  
    def call
      rooster_positions = RoosterPosition.where(scoreboard_id: @event.scoreboard.id)
      rooster_position = rooster_positions.first
      return unless rooster_position
  
      case @move_name
      when "single"
        new_rooster_position = RoosterPosition.new(
          rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
        )
        new_rooster_position.second_base = rooster_position.first_base
        new_rooster_position.third_base = rooster_position.second_base
        new_rooster_position.fourth_base = rooster_position.third_base
        new_rooster_position.first_base = rooster_position.fourth_base
  

        second_batter_rooster = @event.opponent_team_line_ups.find_by(batter_order: 2)&.opponent_rooster_id
        new_rooster_position.first_base = second_batter_rooster if second_batter_rooster
        new_rooster_position.save
      end
    end
  end
  
  IN this code i have implemented that at start my first_base will contain a rooster from opponent_team_line_ups with batter_order 1
  I want a code such that when user select single in rooster_positions there should be new entry such that
   second_base should contain rooster_id that was previously at first_base 
   first_base should have a rooster  from opponent_team_line_ups with batter_order 2
   and third_base and fourth_base will be nil

   please take a note that this much i have implemented uptill now in this code.

   Now what i want is first u understand the code properly
   now in this when user again select single first update the position in rooster_position table
   third_base should contain rooster_id that was previously at second_base 
 second_base should contain rooster_id that was previously at first_base 

 now for first_base there will be a condition which will check if first_base is empty or not if empty then 
 first_base should have a rooster  from opponent_team_line_ups with batter_order 3