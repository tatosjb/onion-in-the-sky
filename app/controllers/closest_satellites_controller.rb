# frozen_string_literal: true

class ClosestSatellitesController < ApplicationController
  def index
    LoadDetailedStarlinkSatellitesAndOrbits.call

    render json: FindTheClosestsSatelites.call(
      latitude: permitted_params[:latitude],
      longitude: permitted_params[:longitude],
      number_of_satellites: permitted_params[:number_of_satellites]
    )
  end

  private

  def permitted_params
    params.permit(:latitude, :longitude, :number_of_satellites, :channel)
  end
end
