# frozen_string_literal: true

class LoadDetailedStarlinkSatellitesAndOrbits < ApplicationService
  STARLINK_URL = 'https://api.spacexdata.com/v4/starlink/query'

  def call
    starlink_data
  end

  private

  def starlink_data
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
