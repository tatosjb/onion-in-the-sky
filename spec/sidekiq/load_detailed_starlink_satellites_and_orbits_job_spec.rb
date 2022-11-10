require 'rails_helper'

RSpec.describe LoadDetailedStarlinkSatellitesAndOrbitsJob, type: :job do
  it 'calls the LoadDetailedStarlinkSatellitesAndOrbits service with all parameters' do
    expect(LoadDetailedStarlinkSatellitesAndOrbits).to receive(:call).with(latitude: 1, longitude: 2, number_of_satellites: 3,
                                                                           channel_identifier: 4)

    LoadDetailedStarlinkSatellitesAndOrbitsJob.perform_sync(1, 2, 3, 4)
  end
end
