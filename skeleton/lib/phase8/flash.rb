require 'json'
require 'webrick'
require 'byebug'

module Phase9
  class Flash
    def initialize(req)
      @req = req
      @cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app_flash" }
      @previous_req = @cookie.nil? ? {} : JSON.parse(@cookie.value)
      @flash_now = {}
      @flash = {}
    end

    def [](key)
      [@flash[key.to_sym],
       @flash[key.to_s],
       @previous_req[key.to_sym],
       @previous_req[key.to_s],
       @flash_now[key.to_s],
       @flash_now[key.to_sym]].flatten.compact
    end

    def []=(flash_type, value)
      @flash[flash_type] = value
    end

    def now
      @flash_now
    end

    def store_flash(res)
      flash_cookie = WEBrick::Cookie.new(
        "_rails_lite_app_flash",
         @flash.to_json
      )
      flash_cookie.path = "/"
      res.cookies << flash_cookie
    end

  end
end
