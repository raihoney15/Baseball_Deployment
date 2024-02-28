class ChangeRoosterPositionsService
        def initialize(event, move_name, current_user)
          @event = event
          @move_name = move_name
          @current_user = current_user
  
        end
  
        def call
          
          rooster_positions = RoosterPosition.where(scoreboard_id: @event.scoreboard.last.id,user_id: @current_user.id)
          
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
          when "strike"
            handle_strike_move(rooster_position)
          when "ball"
            handle_balls_move(rooster_position)
          when "homerun"
            handle_homerun_move(rooster_position)
          end
        end
     

    
      private
    

   
        def handle_single_move(rooster_position)
          
          a1 = @event.scoreboard.last.rooster_positions.last.first_base
          current_batter_order =  @event.opponent_team_line_ups.where(opponent_rooster_id:a1).first.batter_order
          next_batter_order =  @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
          next_batter = next_batter_order.opponent_rooster_id
          
          r = @event.scoreboard.last
          new_scoreboard = Scoreboard.new(
            r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
            )
          new_scoreboard.save

          if next_batter
            
            new_rooster_position = RoosterPosition.new(
              rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
            )
            
            new_rooster_position.scoreboard_id = @event.scoreboard.last.id
            
            new_rooster_position.first_base = next_batter
            
            new_rooster_position.second_base = rooster_position.first_base
            
            new_rooster_position.third_base = rooster_position.second_base
            
            new_rooster_position.fourth_base = rooster_position.third_base
            new_rooster_position.save!
            p = @event.pitching_stats.last
            new_pitching_stat = PitchingStat.new(
            p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
            )
            new_pitching_stat.scoreboard_id = @event.scoreboard.last.id
            new_pitching_stat.pitch += 1
            new_pitching_stat.save!
            
            

            if rooster_position.fourth_base.present?
              r = Scoreboard.find(rooster_position.scoreboard_id)
              new_scoreboard = Scoreboard.new(
              r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
              )
              new_scoreboard.run += 1
              new_scoreboard.save

              b = @event.batting_stats.first
              new_batting_stats = BattingStat.new(
                b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                )
                new_batting_stats.scoreboard_id = @event.scoreboard.last.id
                new_batting_stats.run += 1
                new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                new_batting_stats.save!
            end
          end
        end
        
        def handle_double_move(rooster_position)
          a1 = @event.scoreboard.rooster_positions.last.first_base
          current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
          next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
          next_batter = next_batter_order.opponent_rooster_id

          r = Scoreboard.find(rooster_position.scoreboard_id)
          new_scoreboard = Scoreboard.new(
            r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
            )
          new_scoreboard.save

                if next_batter
                  new_rooster_position = RoosterPosition.new(
                    rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
                  )

                  # p = @event.pitching_stats.first
                  # p.pitch += 1
                  # 
                  # p.save!
                  p = @event.pitching_stats.last
                  new_pitching_stat = PitchingStat.new(
                  p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                  )
                  new_pitching_stat.pitch += 1
                  new_pitching_stat.save!

                    if rooster_position.fourth_base.present?
                      new_rooster_position.fourth_base = nil

                      r = Scoreboard.find(rooster_position.scoreboard_id)
                      new_scoreboard = Scoreboard.new(
                        r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                        )
                      new_scoreboard.run += 1
                      new_scoreboard.save
        
                      b = @event.batting_stats.first
                      new_batting_stats = BattingStat.new(
                        b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                        )
                        new_batting_stats.run += 1
                        new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                        new_batting_stats.save!
                      # r = Scoreboard.find(rooster_position.scoreboard_id)
                      # r.run += 1
                      # r.save

                      # b = @event.batting_stats.first
                      # b.run += 1
                      # b.save

                      if rooster_position.third_base.present?
                        new_rooster_position.third_base = nil


                        r = Scoreboard.find(rooster_position.scoreboard_id)
                        new_scoreboard = Scoreboard.new(
                          r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                          )
                        new_scoreboard.run += 1
                        new_scoreboard.save
          
                        b = @event.batting_stats.first
                        new_batting_stats = BattingStat.new(
                          b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                          )
                          new_batting_stats.run += 1
                          new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                          new_batting_stats.save!
                        # r1 = Scoreboard.find(rooster_position.scoreboard_id)
                        # r1.run += 1
                        # r1.save
                        # b = @event.batting_stats.first
                        # b.run += 1
                        # b.save
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

                      r = Scoreboard.find(rooster_position.scoreboard_id)
                      new_scoreboard = Scoreboard.new(
                        r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                        )
                      new_scoreboard.run += 1
                      new_scoreboard.save
        
                      b = @event.batting_stats.first
                      new_batting_stats = BattingStat.new(
                        b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                        )
                        new_batting_stats.run += 1
                        new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                        new_batting_stats.save!
                      # r1 = Scoreboard.find(rooster_position.scoreboard_id)
                      # r1.run += 1
                      # r1.save
                      # b = @event.batting_stats.first
                      # b.run += 1
                      # b.save

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

          r = Scoreboard.find(rooster_position.scoreboard_id)
          new_scoreboard = Scoreboard.new(
            r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
            )
          new_scoreboard.save

              if next_batter
                new_rooster_position = RoosterPosition.new(
                  rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
                )
                # p = @event.pitching_stats.first
                # p.pitch += 1
                # 
                # p.save!
                p = @event.pitching_stats.last
                new_pitching_stat = PitchingStat.new(
                p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                )
                new_pitching_stat.pitch += 1
                new_pitching_stat.save!
                new_rooster_position.fourth_base = rooster_position.first_base
              
                if rooster_position.second_base.present?
                  rooster_position.second_base = nil
                  new_rooster_position.fourth_base = rooster_position.first_base

                  r = Scoreboard.find(rooster_position.scoreboard_id)
                  new_scoreboard = Scoreboard.new(
                    r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                    )
                  new_scoreboard.run += 1
                  new_scoreboard.save
    
                  b = @event.batting_stats.first
                  new_batting_stats = BattingStat.new(
                    b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                    )
                    new_batting_stats.run += 1
                    new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                    new_batting_stats.save!
                  # r = Scoreboard.find(rooster_position.scoreboard_id)
                  # r.run += 1
                  # r.save
                  # b = @event.batting_stats.first
                  # b.run += 1
                  # b.save
                elsif rooster_position.third_base.present?
                  rooster_position.third_base = nil
                  rooster_position.second_base = nil
                  new_rooster_position.fourth_base = rooster_position.first_base
                  r = Scoreboard.find(rooster_position.scoreboard_id)
                  new_scoreboard = Scoreboard.new(
                    r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                    )
                  new_scoreboard.run += 2
                  new_scoreboard.save
    
                  b = @event.batting_stats.first
                  new_batting_stats = BattingStat.new(
                    b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                    )
                    new_batting_stats.run += 2
                    new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                    new_batting_stats.save!
                  # r = Scoreboard.find(rooster_position.scoreboard_id)
                  # r.run += 2
                  # r.save
                  # b = @event.batting_stats.first
                  # b.run += 2
                  # b.save
                elsif rooster_position.fourth_base.present?
                  rooster_position.fourth_base = nil
                  rooster_position.third_base = nil
                  rooster_position.second_base = nil
                  r = Scoreboard.find(rooster_position.scoreboard_id)
                  new_scoreboard = Scoreboard.new(
                    r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                    )
                  new_scoreboard.run += 3
                  new_scoreboard.save
    
                  b = @event.batting_stats.first
                  new_batting_stats = BattingStat.new(
                    b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
                    )
                    new_batting_stats.run += 3
                    new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
                    new_batting_stats.save!
                  # r = Scoreboard.find(rooster_position.scoreboard_id)
                  # r.run += 3
                  # r.save
                  # b = @event.batting_stats.first
                  # b.run += 3
                  # b.save
                end
              end
            
          new_rooster_position.first_base = next_batter
          new_rooster_position.save
        end 
  
        def handle_out_move(rooster_position)
          

        if @event.scoreboard.last.home_team?
          a1 = @event.scoreboard.last.rooster_positions.last.first_base
          current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
          next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
          next_batter = next_batter_order.opponent_rooster_id
          scoreboard = @event.scoreboard.last
        end
          
        if @event.scoreboard.last.home_away?
            a1 = @event.scoreboard.last.rooster_positions.last.first_base
            current_batter_order = @event.team_line_ups.where(rooster_id: a1).first.batter_order
            next_batter_order = @event.team_line_ups.find_by(batter_order: current_batter_order + 1)
            next_batter = next_batter_order.rooster_id
            scoreboard = @event.scoreboard.last
        end

          if next_batter
            
            r = @event.scoreboard.last
            new_scoreboard = Scoreboard.new(
              r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
              )
            new_scoreboard.out += 1
            new_scoreboard.save
            new_rooster_position = RoosterPosition.new(
              rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield")
            )
            
            new_rooster_position.scoreboard_id = @event.scoreboard.last.id
            
            new_rooster_position.first_base = next_batter
            new_rooster_position.save!


            p = @event.pitching_stats.last
            new_pitching_stat = PitchingStat.new(
            p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
            )
            new_pitching_stat.pitch += 1
            new_pitching_stat.scoreboard_id = @event.scoreboard.last.id
            new_pitching_stat.save!

            

            r = @event.scoreboard.last
            if r.out >= 3
              if @event.event_innings.last.top
                AfterOutService.new(@event, scoreboard, @current_user).call
              end
              if @event.event_innings.last.bottom
                  binding.pry
                  AfterOpponentOutService.new(@event, scoreboard, @current_user).call
                  binding.pry
                i = @event.event_innings.last
                new_inning = EventInning.new(
                  i.attributes.slice("inning_number","top","bottom","event_id")
                )
                new_inning.inning_number += 1    
                new_inning.top =  true
                new_inning.bottom =  false
                new_inning.save
              end
            else 
              
            end
          end
          
        end
          
        def handle_strike_move(rooster_position)

          new_rooster_position = RoosterPosition.new(
            rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield"))        
            r = Scoreboard.find(rooster_position.scoreboard_id)
            new_scoreboard = Scoreboard.new(
              r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
              )
            new_scoreboard.strike += 1
            new_scoreboard.save
            # r = Scoreboard.find(rooster_position.scoreboard_id)
          # r.strike += 1
          # r.save
          p = @event.pitching_stats.last
          new_pitching_stat = PitchingStat.new(
          p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
          )
          new_pitching_stat.pitch += 1
          new_pitching_stat.save!
          # p = @event.pitching_stats.first
          # p.pitch += 1
          # p.save!
          if r.strike >= 3
              handle_out_move(rooster_position)
              r = Scoreboard.find(rooster_position.scoreboard_id)
              new_scoreboard = Scoreboard.new(
                r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
                )
              new_scoreboard.strike = 0
              new_scoreboard.save
              # r.strike = 0 
              # r.save
          else 
            new_rooster_position.save
          end
        end
        
        def handle_balls_move(rooster_position)
          a1 = @event.scoreboard.rooster_positions.last.first_base
          current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
          next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
          next_batter = next_batter_order.opponent_rooster_id
          scoreboard = Scoreboard.find(rooster_position.scoreboard_id)

          new_rooster_position = RoosterPosition.new(
            rooster_position.attributes.slice("scoreboard_id", "user_id", "catcher", "fourth_base", "first_base", "second_base", "third_base", "pitcher", "shortstop", "rightfield", "leftfield", "centerfield"))        
          # r = Scoreboard.find(rooster_position.scoreboard_id)
          # r.balls += 1
          # r.save
          # p = @event.pitching_stats.first
          # p.pitch += 1
          # binding.pry
          # p.save!
          r = Scoreboard.find(rooster_position.scoreboard_id)
          new_scoreboard = Scoreboard.new(
            r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
            )
          new_scoreboard.balls += 1
          new_scoreboard.save

          p = @event.pitching_stats.last
          new_pitching_stat = PitchingStat.new(
          p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
          )
          new_pitching_stat.pitch += 1
          new_pitching_stat.save!

          if r.balls >= 4
            r = Scoreboard.find(rooster_position.scoreboard_id)
            new_scoreboard = Scoreboard.new(
              r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
              )
            new_scoreboard.balls = 0
            new_scoreboard.run += 1
            new_scoreboard.save
            # r = Scoreboard.find(rooster_position.scoreboard_id)
            # r.run += 1
            # r.balls = 0 
            # r.save
            # b = @event.batting_stats.first
            # b.run += 1
            # b.save
            b = @event.batting_stats.first
            new_batting_stats = BattingStat.new(
              b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
              )
              new_batting_stats.run += 1
              new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
              new_batting_stats.save!
            handle_single_move(rooster_position)
          else 
            new_rooster_position.save
          end
        end

        def handle_homerun_move(rooster_position)
          a1 = @event.scoreboard.rooster_positions.last.first_base
          current_batter_order = @event.opponent_team_line_ups.where(opponent_rooster_id: a1).first.batter_order
          next_batter_order = @event.opponent_team_line_ups.find_by(batter_order: current_batter_order + 1)
          next_batter = next_batter_order.opponent_rooster_id
          p = @event.pitching_stats.last
          new_pitching_stat = PitchingStat.new(
          p.attributes.slice("pitch","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
          )
          new_pitching_stat.pitch += 1
          new_pitching_stat.save!
          # p = @event.pitching_stats.first
          # p.pitch += 1
          # p.save!
          r = Scoreboard.find(rooster_position.scoreboard_id)
          new_scoreboard = Scoreboard.new(
            r.attributes.slice("balls","run","strike","out","home_team","home_away","event_id","event_inning_id")
            )
          bases = 0
          bases += 1 if rooster_position.first_base.present?
          bases += 1 if rooster_position.second_base.present?
          bases += 1 if rooster_position.third_base.present?
          bases += 1 if rooster_position.fourth_base.present?
          # r.run += bases
          new_scoreboard.run += bases
          # b = @event.batting_stats.first
          # b.run += bases
          # b.save
          b = @event.batting_stats.first
          new_batting_stats = BattingStat.new(
            b.attributes.slice("run","event_id","scoreboard_id","team_id","opponent_team_id","rooster_id","opponent_rooster_id")
            )
            new_batting_stats.run += bases
            new_batting_stats.opponent_rooster_id = rooster_position.fourth_base
            new_batting_stats.save!
          rooster_position.update(
            first_base: nil,
            second_base: nil,
            third_base: nil,
            fourth_base: nil
          )
          rooster_position.update(first_base: next_batter)
          new_scoreboard.save
          rooster_position.save
        end
end


