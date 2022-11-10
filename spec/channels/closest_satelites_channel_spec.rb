require 'rails_helper'

RSpec.describe ClosestSatelitesChannel, type: :channel do
  it 'accepts subscription' do
    expect(SecureRandom).to receive(:uuid).and_return('uuid')
    expect(ActionCable.server).to receive(:broadcast).with('closest_satelites_uuid', { uuid: 'closest_satelites_uuid' })

    subscribe
  end
end
