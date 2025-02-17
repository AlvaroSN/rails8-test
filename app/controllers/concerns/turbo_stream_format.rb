module TurboStreamFormat
  extend ActiveSupport::Concern

  def set_turbo_stream_format
    request.format = :turbo_stream if request.xhr? || turbo_frame_request?
  end
end