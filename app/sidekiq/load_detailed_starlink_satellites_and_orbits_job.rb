# frozen_string_literal: true

class LoadDetailedStarlinkSatellitesAndOrbitsJob
  include Sidekiq::Job

  STARLINK_URL = 'https://api.spacexdata.com/v4/starlink'

  def perform(latitude, longitude, number_of_satellites, channel_identifier)
    LoadDetailedStarlinkSatellitesAndOrbits.call(
      channel_identifier: channel_identifier,
      latitude: latitude,
      longitude: longitude,
      number_of_satellites: number_of_satellites
    )
  end
end
