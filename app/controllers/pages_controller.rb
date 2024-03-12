class PagesController < ApplicationController
  def home
    
    if current_user.present?
      @live_events = current_user.events.where(is_live: true)
    else
      @live_events = Event.where(is_live: true)
    end

      @live_events_with_scoreboards = @live_events.map do |event|
        { event: event, scoreboards: event.scoreboards.last }
      end

    if current_user.present?
      @over_matches = current_user.events.where(is_live: false).where('event_innings.inning_number = ?', 9).joins(:event_innings)
    else
      @over_matches = Event.where(is_live: false).where('event_innings.inning_number = ?', 9).joins(:event_innings)
    end  
    @over_matches_with_scoreboards = @over_matches.map do |event|
      { event: event, scoreboards: event.scoreboards.last }
    end

    if current_user.present?
      @upcoming_events = current_user.events.where('start_date > ?', Date.today).where(is_live: nil)
      
    else
      @upcoming_events = Event.where('start_date > ?', Date.today).where(is_live: nil)
    end
    
    

  end

end



