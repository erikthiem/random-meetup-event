require 'rails_helper'
require 'support/meetup_request'

RSpec.feature 'Manual location selection', type: :feature do
  include_context 'meetup_response'

  before do
    stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body.to_json , headers: {})
  end

  describe 'the user selects a location' do
    context 'when the selected city has Meetup results' do
      specify 'the page displays information for the selected city' do

        visit '/'
        expect(page).to have_text("City")
        expect(page).to have_text("State")
        expect(page).to have_text("Country")

        page.fill_in 'City', with: 'Columbus'
        page.fill_in 'State', with: 'OH'
        page.fill_in 'Country', with: 'US'

      end
    end

    context 'when the selected city does not have Meetup results' do
      specify 'the page displays a no results found message' do
        visit '/'
        expect(page).to have_text('No nearby events found :(')
      end
    end
  end
end
