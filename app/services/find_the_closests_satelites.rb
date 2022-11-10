# frozen_string_literal: true

class FindTheClosestsSatelites < ApplicationService
  def initialize(starlink_data:, latitude:, longitude:, number_of_satellites: nil)
    @latitude = latitude.to_f
    @longitude = longitude.to_f
    @number_of_satellites = (number_of_satellites.presence || 10).to_i
    @starlink_data = starlink_data
  end

  def call
    return [] unless starlink_data.present?

    starlink_data
      .sort_by { |satellite| distance(satellite) }
      .first(number_of_satellites)
  end

  private

  attr_reader :latitude, :longitude, :number_of_satellites, :starlink_data

  def distance(satellite)
    Haversine.distance(
      [latitude, longitude],
      [satellite['latitude'], satellite['longitude']]
    )
  end
end
