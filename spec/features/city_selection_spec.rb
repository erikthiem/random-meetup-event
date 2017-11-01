require 'rails_helper'
require 'support/meetup_response'

RSpec.feature 'City selection', js: true, type: :feature do
  include_context 'meetup_response'

  let(:body) { meetup_body }

  before do
    stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body.to_json , headers: {})
    stub_request(:get, %r{http://127.0.0.1}).with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: 200, body: "", headers: {})
  end

  context 'when the city is automatically detected', geolocation: true do
    let(:city) { 'New York, NY, US' }

    specify 'the page displays the city' do
      visit '/'
      expect(page).to have_text(city)
    end
  end

  context 'when the city is not automatically detected' do
    specify 'the page defaults to using Columbus' do
      visit '/'
      expect(page).to have_text('Columbus, OH, USA')
    end
  end
end
