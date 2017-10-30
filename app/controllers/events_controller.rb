class EventsController < ApplicationController
  def show
    @event = MeetupGetter.event
    return if not @event
    @group = @event['group']['name']
    @start_time = Time.at(@event['time']/1000).strftime("%D %I:%M %p")
    @end_time = Time.at(@event['time']/1000 + @event['duration']/1000).strftime("%D %I:%M %p")
  end
end
