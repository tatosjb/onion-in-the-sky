require 'rails_helper'

RSpec.describe LoadDetailedStarlinkSatellitesAndOrbitsJob, type: :job do
  it 'calls the LoadDetailedStarlinkSatellitesAndOrbits service' do
    expect(LoadDetailedStarlinkSatellitesAndOrbits).to receive(:call)

    LoadDetailedStarlinkSatellitesAndOrbitsJob.perform_sync
  end
end
