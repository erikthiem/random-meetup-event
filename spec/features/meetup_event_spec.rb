require 'rails_helper'

RSpec.feature 'Display meetup event', type: :feature do
  let(:body) { {'results': []}.to_json }
  let(:status) { 200 }

  before do
    stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body , headers: {})
  end


  context 'when there is at least one nearby event' do

    let(:body) { {'results': [{name: :event_name}]}.to_json }
    let(:event_name) { 'Fun-sounding Thing' }

    specify do
      visit '/'
      expect(page).to have_text(:event_name)
    end
  end

  context 'when there are not nearby events' do

    specify do
      visit '/'
      expect(page).to have_text('No nearby events found :(')
    end
  end

end
