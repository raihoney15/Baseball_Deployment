class PagesController < ApplicationController
  def home
    @live_events = Event.where(is_live: true)
    @live_events_with_scoreboards = @live_events.map do |event|
      { event: event, scoreboards: event.scoreboards.last }
    end


  end

end
