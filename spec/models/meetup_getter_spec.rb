require 'rails_helper'

RSpec.describe MeetupGetter, type: :model do
  describe '.get_nearby_event' do

    let(:body) { {'results': []}.to_json }
    let(:status) { 200 }

    before do
      stub_request(:get, %r{api.meetup.com/2/open_events}).with(headers: {'Accept'=>'*/*', 'Accept-Charset'=>'UTF-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).to_return(status: status, body: body , headers: {})
    end

    context 'when there are many nearby events' do
      let(:body) { {'results': [{event_url: test_urls[0]}, {event_url: test_urls[1]}]}.to_json }
      let(:test_urls) { ['http://test1', 'http://test2'] }
      it 'returns a random event' do
        expect(described_class.get_nearby_event['event_url']).to be_in test_urls
      end

    end

    context 'when there is one nearby event' do
  
      let(:body) { {'results': [{event_url: test_url}]}.to_json }
      let(:test_url) { 'http://testurl ' }

      it 'returns the nearby event' do
        expect(described_class.get_nearby_event['event_url']).to eq test_url
      end
    end

    context 'when there are no nearby events' do

      it 'returns nil' do
        expect(described_class.get_nearby_event).to be_nil
      end
    end

    context 'when it cannot get a connection to the Meetup api' do

      let(:status) { 404 }

      it 'returns nil' do
        expect(described_class.get_nearby_event).to be_nil
      end
    end
  end
end
