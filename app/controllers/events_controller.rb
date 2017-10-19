class EventsController < ApplicationController
  def random
    nearby_events.sample
  end

  private

  def nearby_events
    params = { 
      city: 'columbus',
      state: 'oh',
      country: 'us',
      status: 'upcoming',
      format: 'json',
      page: '50'}
    meetup_api = MeetupApi.new
    @events ||= meetup_api.open_events(params)['results']
  end
end
