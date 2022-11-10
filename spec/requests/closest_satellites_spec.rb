require 'rails_helper'

RSpec.describe 'ClosestSatellites', type: :request do
  let(:starlink_data) do
    [
      { 'latitude' => 1, 'longitude' => 1, id: 'abc' },
      { 'latitude' => 2, 'longitude' => 2, id: 'efg' },
      { 'latitude' => 3, 'longitude' => 3, id: 'hij' },
      { 'latitude' => 4, 'longitude' => 4, id: 'klm' },
      { 'latitude' => 5, 'longitude' => 5, id: 'nop' },
      { 'latitude' => 6, 'longitude' => 6, id: 'qrs' },
      { 'latitude' => 7, 'longitude' => 7, id: 'tuv' },
      { 'latitude' => 8, 'longitude' => 8, id: 'wxy' },
      { 'latitude' => 9, 'longitude' => 9, id: 'z01' },
      { 'latitude' => 10, 'longitude' => 10, id: '234' },
      { 'latitude' => 11, 'longitude' => 11, id: '567' }
    ]
  end

  before do
    allow(LoadDetailedStarlinkSatellitesAndOrbits).to receive(:call).and_return(starlink_data)
  end

  describe 'GET /index' do
    describe 'when there are no satellites' do
      let(:starlink_data) { [] }

      it 'returns an empty array' do
        get closest_satellites_path

        expect(response).to have_http_status(:ok)
        expect(response.body).to eql '[]'
      end
    end

    describe 'when there are satellites' do
      it 'returns the closest satellites' do
        get closest_satellites_path, params: { latitude: '0', longitude: '0', number_of_satellites: '3' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to match_array starlink_data[0..2].map(&:stringify_keys)
      end

      it 'returns 10 satellites when ther number of satelites is nil' do
        get closest_satellites_path, params: { latitude: '6', longitude: '6' }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to match_array starlink_data[1..10].map(&:stringify_keys)
      end
    end
  end
end
