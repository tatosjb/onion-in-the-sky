require 'rails_helper'

RSpec.describe LoadDetailedStarlinkSatellitesAndOrbits do
  let(:response) do
    {
      docs: [
        { 'latitude' => 26.065623780998646, 'longitude' => -133.95304866064313, 'id' => '63655b77358d5951a1c69e39' },
        { 'latitude' => 30.18928829508964, 'longitude' => -138.22386905476995, 'id' => '63655b77358d5951a1c69e41' }
      ]
    }
  end
  let(:headers) { { 'Content-Type': 'application/json' } }
  let(:body) do
    {
      query: {
        latitude: {
          '$ne' => nil
        },
        longitude: {
          '$ne' => nil
        }
      },
      options: {
        select: {
          latitude: 1,
          longitude: 1
        },
        pagination: false
      }
    }.to_json
  end

  before do
    stub_request(:post, 'https://api.spacexdata.com/v4/starlink/query')
      .with(body: body, headers: headers)
      .to_return(status: 200, body: response.to_json, headers: headers)
  end

  it 'returns the detailed starlink satellites and orbits' do
    described_class.call

    expect(described_class.call).to eql response.deep_stringify_keys['docs']
  end
end
