require 'rails_helper'
require 'support/meetup_request'

RSpec.describe MeetupGetter, type: :model do
  include_context 'meetup_response'

  describe '.event' do

    before do
      stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body.to_json , headers: {})
    end

    context 'when there are many nearby events' do
      let(:body) { meetup_body_multiple_results }

      it 'returns a random event' do
        expect(described_class.event['event_url']).to be_in [event_url, event2_url]
      end

    end

    context 'when there is one nearby event' do
  
      let(:body) { meetup_body_single_result }

      it 'returns the nearby event' do
        expect(described_class.event['event_url']).to eq event_url
      end
    end

    context 'when there are no nearby events' do

      let(:body) { meetup_body_no_results }

      it 'returns nil' do
        expect(described_class.event).to be_nil
      end
    end

    context 'when it cannot get a connection to the Meetup api' do
      # TODO: I'm not sure that this is doing what I think it is doing. Is a 404 from
      # Meetup actually being handled?
      # At any rate, this would probably be better to switch from checking for a 404
      # to checking for NOT a 200 in the implementation.

      let(:body) { { 'results': [] } }
      let(:status) { 404 }

      it 'returns nil' do
        expect(described_class.event).to be_nil
      end
    end
  end
end
