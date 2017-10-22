require 'rails_helper'
require 'support/meetup_request'

RSpec.feature 'Display meetup event', type: :feature do
  include_context 'meetup_response'

  before do
    stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body.to_json , headers: {})
  end

  context 'when there is more than one nearby event' do

    let(:body) { meetup_body_multiple_results }

    specify "clicking 'Anything Else?' gets a random event" do
      visit '/'
      expect(find('#event-link').text).to be_in([event_name, event2_name])
      expect(find('#event-link')[:href]).to be_in([event_url, event2_url])
      click_link 'Anything else?'
      expect(find('#event-link').text).to be_in([event_name, event2_name])
      expect(find('#event-link')[:href]).to be_in([event_url, event2_url])
    end
  end

  context 'when there is at least one nearby event' do

    let(:body) { meetup_body }

    specify 'the page displays information about the event' do
      visit '/'
      expect(page).to have_link(event_name, event_url)
      expect(page).to have_text(group)
      expect(page).to have_text(start_time)
      expect(page).to have_text(end_time)
    end
  end

  context 'when there are no nearby events' do

    let(:body) do
      { 'results': [] }
    end

    specify "the page displays 'No nearby events found :('"do
      visit '/'
      expect(page).to have_text('No nearby events found :(')
    end
  end
end
