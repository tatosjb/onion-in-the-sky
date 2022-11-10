# frozen_string_literal: true

class LoadDetailedStarlinkSatellitesAndOrbits < ApplicationService
  STARLINK_URL = 'https://api.spacexdata.com/v4/starlink/query'

  def initialize(latitude: nil, longitude: nil, number_of_satellites: nil, channel_identifier: nil)
    @channel_identifier = channel_identifier
    @latitude = latitude.to_f
    @longitude = longitude.to_f
    @number_of_satellites = (number_of_satellites.presence || 10).to_i
  end

  def call
    Rails.logger.info('Writing Starlink satellites to cache')
    Rails.cache.write('starlink', starlink_data)
    return unless Rails.cache.read('starlink').present?

    current_time = Time.now.utc
    Rails.cache.write('starlink_updated_at', current_time)

    broadcast_to_channel if @channel_identifier.present?
  end

  private

  attr_reader :channel_identifier, :latitude, :longitude, :number_of_satellites

  def starlink_data
    Rails.logger.info("Fetching Starlink satellites from #{STARLINK_URL}") if defined?(@starlink_data)

    @starlink_data ||= HTTP.post(STARLINK_URL, {
                                   headers: headers,
                                   body: body.to_json
                                 })
                           .parse['docs']
  end

  def headers
    {
      'Content-Type': 'application/json'
    }
  end

  def body # rubocop:disable Metrics/MethodLength
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
    }
  end

  def broadcast_to_channel
    Rails.logger.info("Broadcasting to channel #{channel_identifier}")
    ActionCable.server.broadcast(
      channel_identifier,
      { satellites: FindTheClosestsSatelites.call(
        latitude: latitude,
        longitude: longitude,
        number_of_satellites: number_of_satellites
      ) }
    )
  end
end
