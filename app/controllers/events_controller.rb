class EventsController < ApplicationController
  def random
    @event = MeetupGetter.get_nearby_event
  end

end
