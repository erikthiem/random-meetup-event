class EventsController < ApplicationController
  def show
    @event = MeetupGetter.event
    return if not @event
    @group = @event['group']['name']

    if @event['time']
      @start_time = Time.at(@event['time']/1000).strftime("%D %I:%M %p")
    else
      @start_time = "Unknown"
    end

    if @event['time'] && @event['duration']
      @end_time = Time.at(@event['time']/1000 + @event['duration']/1000).strftime("%D %I:%M %p")
    else
      @end_time = "Unknown"
    end
  end
end
