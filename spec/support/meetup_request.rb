shared_context 'meetup_response' do
  let(:meetup_body_single_result) do
    {'results': [
      {
        name: event_name,
        event_url: event_url,
        time: start_time,
        duration: duration,
        group: {
          name: group
        }
      }
    ]}
  end

  let(:meetup_body_multiple_results) do
    {'results': [
      {
        name: event_name,
        event_url: event_url,
        time: start_time,
        duration: duration,
        group: {
          name: group
        }
      },
      {
        name: event2_name,
        event_url: event2_url,
        time: start_time,
        duration: duration,
        group: {
          name: group
        }
      }
    ]}
  end

  let(:meetup_body_no_results) do
    {'results': nil }
  end

  let(:status) { 200 }

  let(:event_name) { 'Fun-sounding Thing' }
  let(:event_url) { 'http://meetup/funthing' }
  let(:event2_name) { 'something else' }
  let(:event2_url) { 'http://meetup/otherthing' }
  let(:start_time) { 1508605200000 }
  let(:duration) { 18000000 }
  let(:end_time) { start_time + duration }
  let(:group) { 'a random group' }

end
