# frozen_string_literal: true

class LoadDetailedStarlinkSatellitesAndOrbitsJob
  include Sidekiq::Job

  STARLINK_URL = 'https://api.spacexdata.com/v4/starlink'

  def perform
    LoadDetailedStarlinkSatellitesAndOrbits.call
  end
end
