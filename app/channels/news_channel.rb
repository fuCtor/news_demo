class NewsChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'index'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
