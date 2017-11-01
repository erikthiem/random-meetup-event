class MeetupGetter
  def self.event
    nearby_events.try :sample
  end

  private

  def self.nearby_events
    params = {
      city: 'columbus',
      state: 'oh',
      country: 'us',
      status: 'upcoming',
      format: 'json',
      page: '50'
    }
    meetup_api = MeetupApi.new
    meetup_api.open_events(params)['results']
  end
end
