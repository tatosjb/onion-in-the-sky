# frozen_string_literal: true

class AsyncClosestSatellitesController < ApplicationController
  def index
    load_detailed_starlink_satellites_and_orbits_job

    render json: FindTheClosestsSatelites.call(
      latitude: permitted_params[:latitude],
      longitude: permitted_params[:longitude],
      number_of_satellites: permitted_params[:number_of_satellites]
    )
  end

  private

  def load_detailed_starlink_satellites_and_orbits_job
    LoadDetailedStarlinkSatellitesAndOrbitsJob.perform_async(
      permitted_params[:latitude],
      permitted_params[:longitude],
      permitted_params[:number_of_satellites],
      permitted_params[:channel]
    )
  end

  def permitted_params
    params.permit(:latitude, :longitude, :number_of_satellites, :channel)
  end
end
