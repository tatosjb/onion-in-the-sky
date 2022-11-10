# frozen_string_literal: true

class ClosestSatelitesChannel < ApplicationCable::Channel
  def subscribed
    channel_name = "closest_satelites_#{SecureRandom.uuid}"
    p "channel_name: #{channel_name}"
    stream_from channel_name

    ActionCable.server.broadcast(channel_name, { uuid: channel_name })
  end
end
