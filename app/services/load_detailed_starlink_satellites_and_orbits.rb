# frozen_string_literal: true

class LoadDetailedStarlinkSatellitesAndOrbits < ApplicationService
  STARLINK_URL = 'https://api.spacexdata.com/v4/starlink/query'

  def call
    Rails.logger.info("Writing Starlink #{starlink_data.size} satellites to database")
    Rails.cache.write('starlink', starlink_data)

    return unless Rails.cache.read('starlink').present?

    current_time = Time.now.utc
    Rails.logger.info("Starlink satellites written to database at #{current_time}")
    Rails.cache.write('starlink_updated_at', current_time)
  end

  private

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
end
