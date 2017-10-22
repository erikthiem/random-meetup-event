class EventsController < ApplicationController
  def show
    @event = MeetupGetter.get_nearby_event
  end
end
