require 'rails_helper'

RSpec.describe LoadDetailedStarlinkSatellitesAndOrbits do
  let(:response) { { any_data: '' } }

  before do
    stub_request(:get, 'https://api.spacexdata.com/v4/starlink')
      .to_return(status: 200, body: response.to_json, headers: { 'Content-Type': 'application/json' })
  end

  it 'loads the detailed starlink satellites and orbits to cache' do
    described_class.call

    expect(Rails.cache.read('starlink')).to be_present
    expect(Rails.cache.read('starlink')).to eql response.stringify_keys
  end

  it 'sets the updated at time' do
    travel_to Time.zone.local(2021, 1, 1, 0, 0, 0) do
      described_class.call

      expect(Rails.cache.read('starlink_updated_at')).to eql Time.zone.local(2021, 1, 1, 0, 0, 0)
    end
  end
end
