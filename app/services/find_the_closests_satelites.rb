# frozen_string_literal: true

class FindTheClosestsSatelites < ApplicationService
  def initialize(latitude:, longitude:, number_of_satellites: nil)
    @latitude = latitude.to_f
    @longitude = longitude.to_f
    @number_of_satellites = (number_of_satellites.presence || 10).to_i
  end

  def call
    return [] unless starlink_data.present?

    starlink_data
      .sort_by { |satellite| distance(satellite) }
      .first(number_of_satellites)
  end

  private

  attr_reader :latitude, :longitude, :number_of_satellites

  def starlink_data
    @starlink_data ||= Rails.cache.read('starlink')
  end

  def distance(satellite)
    Haversine.distance(
      [latitude, longitude],
      [satellite['latitude'], satellite['longitude']]
    )
  end
end
