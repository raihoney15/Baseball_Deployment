  class ChangeRoosterPositionsService

    def initialize(event, move_name, current_user_id, call_from_service)
      @event = event
      @move_name = move_name
      @current_user_id = current_user_id
      @call_from_service = true
    end
  
    def call
      # binding.pry
      rooster_positions = RoosterPosition.where(scoreboard_id: @event.scoreboard.id,user_id: @current_user_id.id)
      rooster_position = rooster_positions.last
      # binding.pry

      return unless rooster_position
      # binding.pry

      case @move_name
      when "single"
        handle_single_move(rooster_position)
      end
    end
     
    private
   
    def handle_single_move(rooster_position)

      a1 = @event.scoreboard.rooster_positions.last.first_base
      current_batter_order =  @event.opponent_team_line_ups.where(opponent_rooster_id:a1).first.batter_order
      next_batter_order =  @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
      next_batter = next_batter_order.opponent_rooster_id

      if next_batter
        new_rooster_position = RoosterPosition.new(
          rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
        )

        if rooster_position.fourth_base.present?
          new_rooster_position.fourth_base = nil

          r = Scoreboard.find(rooster_position.scoreboard_id)
          r.run += 1
          r.save
          # r = @event.scoreboard.run
          # r += 1
          # r.update
         

          # binding.pry
          # scoreboard = Scoreboard.find(rooster_position.scoreboard_id)
          if rooster_position.third_base.present?
            new_rooster_position.fourth_base = rooster_position.third_base
            new_rooster_position.third_base = nil

            # binding.pry
     
            if rooster_position.second_base.present?
              new_rooster_position.third_base = rooster_position.second_base
              new_rooster_position.second_base = nil
    
           
              if rooster_position.first_base.present?
                new_rooster_position.second_base = rooster_position.first_base
                new_rooster_position.first_base = nil
              end
            end
          end
        elsif rooster_position.third_base.present?
          new_rooster_position.fourth_base = rooster_position.third_base
          new_rooster_position.third_base = nil
    
   
          if rooster_position.second_base.present?
            new_rooster_position.third_base = rooster_position.second_base
            new_rooster_position.second_base = nil
    
            if rooster_position.first_base.present?
              new_rooster_position.second_base = rooster_position.first_base
              new_rooster_position.first_base = nil
            end
          end
        elsif rooster_position.second_base.present?
          new_rooster_position.third_base = rooster_position.second_base
          new_rooster_position.second_base = nil
    
 
          if rooster_position.first_base.present?
            new_rooster_position.second_base = rooster_position.first_base
            new_rooster_position.first_base = nil
          end
        elsif rooster_position.first_base.present?
          new_rooster_position.second_base = rooster_position.first_base
          new_rooster_position.first_base = nil
        end
    
        new_rooster_position.first_base = next_batter

        new_rooster_position.save
        # scoreboard = Scoreboard.find(rooster_position.scoreboard_id)
      
      end
    end
    
    
    

  end
  
