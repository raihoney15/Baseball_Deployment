class GameOverService
    def initialize(event, current_user)
      @event = event
      @current_user = current_user
    end
  
    def call
        
         @s = @event.event_innings.where(inning_number: 1,top:true).ids 
         @s1 = @event.event_innings.where(inning_number: 2,top:true).ids 
         @s2 = @event.event_innings.where(inning_number: 3,top:true).ids 
         @s3 = @event.event_innings.where(inning_number: 4,top:true).ids 
         @s4 = @event.event_innings.where(inning_number: 5,top:true).ids 
         @s5 = @event.event_innings.where(inning_number: 6,top:true).ids 
         @s6 = @event.event_innings.where(inning_number: 7,top:true).ids 
         @s7 = @event.event_innings.where(inning_number: 8,top:true).ids 
         @s8 = @event.event_innings.where(inning_number: 9,top:true).ids
         @r1=@event.scoreboards.where(event_inning_id: @s).last&.run 
         @r2=@event.scoreboards.where(event_inning_id: @s1).last&.run 
         @r3=@event.scoreboards.where(event_inning_id: @s2).last&.run 
         @r4=@event.scoreboards.where(event_inning_id: @s3).last&.run 
         @r5=@event.scoreboards.where(event_inning_id: @s4).last&.run 
         @r6=@event.scoreboards.where(event_inning_id: @s5).last&.run 
         @r7=@event.scoreboards.where(event_inning_id: @s6).last&.run 
         @r8= @event.scoreboards.where(event_inning_id: @s7).last&.run 
         @r9=@event.scoreboards.where(event_inning_id: @s8).last&.run 
         @run = @r1.to_i+@r2.to_i+@r3.to_i+@r4.to_i+@r5.to_i+@r6.to_i+@r7.to_i+@r8.to_i+@r9.to_i 
    
         @o = @event.event_innings.where(inning_number: 1,bottom:true ).ids 
         @o1 = @event.event_innings.where(inning_number: 2,bottom:true).ids 
         @o2 = @event.event_innings.where(inning_number: 3,bottom:true).ids 
         @o3 = @event.event_innings.where(inning_number: 4,bottom:true).ids 
         @o4 = @event.event_innings.where(inning_number: 5,bottom:true).ids 
         @o5 = @event.event_innings.where(inning_number: 6,bottom:true).ids 
         @o6 = @event.event_innings.where(inning_number: 7,bottom:true).ids 
         @o7 = @event.event_innings.where(inning_number: 8,bottom:true).ids 
         @o8 = @event.event_innings.where(inning_number: 9,bottom:true).ids 
         @or1=@event.scoreboards.where(event_inning_id: @o).last&.run 
         @or2=@event.scoreboards.where(event_inning_id: @o1).last&.run 
         @or3=@event.scoreboards.where(event_inning_id: @o2).last&.run 
         @or4=@event.scoreboards.where(event_inning_id: @o3).last&.run 
         @or5=@event.scoreboards.where(event_inning_id: @o4).last&.run 
         @or6=@event.scoreboards.where(event_inning_id: @o5).last&.run                 
         @or7=@event.scoreboards.where(event_inning_id: @o6).last&.run 
         @or8=@event.scoreboards.where(event_inning_id: @o7).last&.run 
         @or9=@event.scoreboards.where(event_inning_id: @o8).last&.run 
        

         @orun = @or1.to_i+@or2.to_i+@or3.to_i+@or4.to_i+@or5.to_i+@or6.to_i+@or7.to_i+@or8.to_i+@or9.to_i
        

        
        winning_team_id = @event.team_id if @run < @orun
        winning_team_id = @event.opponent_team_id if @run > @orun
        @event.update!(is_live: false, winning_team_id: winning_team_id)

        
       
        
      
    end
  end
  
  
  
  
