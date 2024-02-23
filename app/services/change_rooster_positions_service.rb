class ChangeRoosterPositionsService

          def initialize(event, move_name, current_user_id, call_from_service)
            @event = event
            @move_name = move_name
            @current_user_id = current_user_id
            @call_from_service = true
          end
  
          def call
            rooster_positions = RoosterPosition.where(scoreboard_id: @event.scoreboard.id,user_id: @current_user_id.id)
            rooster_position = rooster_positions.last
            return unless rooster_position
            case @move_name
            when "single"
              handle_single_move(rooster_position)
            when "double"
              handle_double_move(rooster_position)
            when "triple"
              handle_triple_move(rooster_position)
            when "out"
              handle_out_move(rooster_position)
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

              new_rooster_position.first_base = next_batter
              new_rooster_position.second_base = rooster_position.first_base
              new_rooster_position.third_base = rooster_position.second_base
              new_rooster_position.fourth_base = rooster_position.third_base
              

              new_rooster_position.save
              if rooster_position.fourth_base.present?
                r = Scoreboard.find(rooster_position.scoreboard_id)
                r.run += 1
                r.save
              end
            
            end
          end
    


    
          def handle_double_move(rooster_position)
            a1 = @event.scoreboard.rooster_positions.last.first_base
            current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
            next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
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

                        if rooster_position.third_base.present?
                          new_rooster_position.third_base = nil

                          r1 = Scoreboard.find(rooster_position.scoreboard_id)
                          r1.run += 1
                          r1.save
                        else
                          new_rooster_position.third_base = rooster_position.first_base

                          if rooster_position.second_base.present?
                            new_rooster_position.fourth_base = rooster_position.second_base
                            new_rooster_position.third_base = rooster_position.first_base
                            new_rooster_position.second_base = nil
                          else
                            new_rooster_position.third_base = rooster_position.first_base

                            if rooster_position.first_base.present?
                              new_rooster_position.third_base = rooster_position.first_base
                              new_rooster_position.first_base = nil
                            end
                          end
                        end
                      elsif rooster_position.third_base.present?
                        new_rooster_position.third_base = nil

                        r1 = Scoreboard.find(rooster_position.scoreboard_id)
                        r1.run += 1
                        r1.save

                        if rooster_position.second_base.present?
                          new_rooster_position.fourth_base = rooster_position.second_base
                          new_rooster_position.third_base = rooster_position.first_base
                          new_rooster_position.second_base = nil
                        else
                          new_rooster_position.third_base = rooster_position.first_base

                          if rooster_position.first_base.present?
                            new_rooster_position.third_base = rooster_position.first_base
                            new_rooster_position.first_base = nil
                          end
                        end
                      elsif rooster_position.second_base.present?
                        new_rooster_position.fourth_base = rooster_position.second_base
                        new_rooster_position.third_base = rooster_position.first_base
                        new_rooster_position.second_base = nil
                      else
                        new_rooster_position.third_base = rooster_position.first_base

                        if rooster_position.first_base.present?
                          new_rooster_position.third_base = rooster_position.first_base
                          new_rooster_position.first_base = nil
                        end
                      end
                    new_rooster_position.first_base = next_batter
                    new_rooster_position.save
                  end
          end

      
        def handle_triple_move(rooster_position)
              a1 = @event.scoreboard.rooster_positions.last.first_base
              current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
              next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
              next_batter = next_batter_order.opponent_rooster_id



                  if next_batter
                    new_rooster_position = RoosterPosition.new(
                      rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
                    )
                    new_rooster_position.fourth_base = rooster_position.first_base
                  
                    if rooster_position.second_base.present?
                      rooster_position.second_base = nil
                      new_rooster_position.fourth_base = rooster_position.first_base
                      r = Scoreboard.find(rooster_position.scoreboard_id)
                      r.run += 1
                      r.save
                    elsif rooster_position.third_base.present?
                      rooster_position.third_base = nil
                      rooster_position.second_base = nil
                      new_rooster_position.fourth_base = rooster_position.first_base
                      r = Scoreboard.find(rooster_position.scoreboard_id)
                      r.run += 2
                      r.save
                    elsif rooster_position.fourth_base.present?
                      rooster_position.fourth_base = nil
                      rooster_position.third_base = nil
                      rooster_position.second_base = nil
                      r = Scoreboard.find(rooster_position.scoreboard_id)
                      r.run += 3
                      r.save
                    end
                  end
                  

              new_rooster_position.first_base = next_batter
              new_rooster_position.save
          end 
  



          def handle_out_move(rooster_position)
            a1 = @event.scoreboard.rooster_positions.last.first_base
            current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
            next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
            next_batter = next_batter_order.opponent_rooster_id
            scoreboard = Scoreboard.find(rooster_position.scoreboard_id)
          
            if next_batter
              new_rooster_position = RoosterPosition.new(
                rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
              )
          
              new_rooster_position.first_base = next_batter
              r = Scoreboard.find(rooster_position.scoreboard_id)
              r.out += 1
              r.save
              binding.pry
              if r.out >= 3
                binding.pry
                current_inning = @event.event_innings.last
                binding.pry
                current_inning.update(bottom: true, top: false)
                binding.pry

                EventInning.create( bottom: true, event_id: @event.id)
                binding.pry

                @event.team_line_ups.each do |team_line_up|
                  binding.pry
                  rooster_position = RoosterPosition.find_or_create_by(scoreboard_id: scoreboard.id, user_id: @current_user_id)
                  binding.pry
                  position_name = Position.find(opponent_team_line_up.position_id).position_name.downcase
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
            new_rooster_position.save
          end
          
end

