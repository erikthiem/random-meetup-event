require 'rails_helper'

RSpec.feature 'Display meetup event', type: :feature do
  let(:body) { {'results': []}.to_json }
  let(:status) { 200 }

  before do
    stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body , headers: {})
  end

  context 'when there is more than one nearby event' do

    let(:body) { {'results': [{name: event_name, event_url: event_url}, {name: event2_name, event_url: event2_url}]}.to_json }
    let(:event_name) { 'Fun-sounding Thing' }
    let(:event_url) { 'http://meetup/funthing' }
    let(:event2_name) { 'something else' }
    let(:event2_url) { 'http://meetup/otherthing' }

    specify do
      visit '/'
      expect(find('#event-link').text).to be_in([event_name, event2_name])
      expect(find('#event-link')[:href]).to be_in([event_url, event2_url])
      click_link 'Anything else?'
      expect(find('#event-link').text).to be_in([event_name, event2_name])
      expect(find('#event-link')[:href]).to be_in([event_url, event2_url])
    end
  end

  context 'when there is at least one nearby event' do

    let(:body) { {'results': [{name: event_name, event_url: event_url}]}.to_json }
    let(:event_name) { 'Fun-sounding Thing' }
    let(:event_url) { 'http://meetup/funthing' }

    specify do
      visit '/'
      expect(page).to have_link(event_name, event_url)
    end
  end

  context 'when there are not nearby events' do

    specify do
      visit '/'
      expect(page).to have_text('No nearby events found :(')
    end
  end

end
