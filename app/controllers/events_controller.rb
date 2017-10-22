class EventsController < ApplicationController
  def show
    @event = MeetupGetter.event
  end
end
