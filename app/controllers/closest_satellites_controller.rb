# frozen_string_literal: true

class ClosestSatellitesController < ApplicationController
  def index
    starlink_data = LoadDetailedStarlinkSatellitesAndOrbits.call

    render json: FindTheClosestsSatelites.call(
      starlink_data: starlink_data,
      latitude: permitted_params[:latitude],
      longitude: permitted_params[:longitude],
      number_of_satellites: permitted_params[:number_of_satellites]
    )
  end

  private

  def permitted_params
    params.permit(:latitude, :longitude, :number_of_satellites)
  end
end
