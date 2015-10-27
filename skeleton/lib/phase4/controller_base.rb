require_relative '../phase3/controller_base'
require_relative './session'
require 'byebug'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      self.session.store_session(res)
      super(url)
    end

    def render_content(content, content_type)
      self.session.store_session(res)
      super(content, content_type)
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(req)
    end
  end
end
