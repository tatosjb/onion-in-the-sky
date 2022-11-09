require 'rails_helper'

RSpec.describe FindTheClosestsSatelites do
  describe '#call' do
    describe 'when there are no satellites' do
      it 'returns an empty array' do
        result = described_class.call(latitude: 0, longitude: 0, number_of_satellites: 0)

        expect(result).to eql []
      end
    end

    describe 'when there are satellites' do
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
        allow(Rails.cache).to receive(:read).with('starlink').and_return(starlink_data)
      end

      it 'returns the closest satellites' do
        result = described_class.call(latitude: 0, longitude: 0, number_of_satellites: 1)

        expect(result).to eql [starlink_data.first]
      end

      it 'returns 10 satellites when ther number of satelites is not set' do
        result = described_class.call(latitude: 6, longitude: 6)

        expect(result).to match_array starlink_data[1..10]
      end
    end
  end
end
