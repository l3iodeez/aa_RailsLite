require 'json'
require 'webrick'
require 'byebug'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = req.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
      if cookie
        @items = JSON.parse(cookie.value)
      else
        @items = {}
      end

    end

    def [](key)
      @items[key]
    end

    def []=(key, val)
      @items[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      cookie = get_cookie(res)
      cookie.value = @items.to_json
      res.cookies << cookie

    end

    def get_cookie(obj)
      cookie = obj.cookies.find { |cookie| cookie.name == "_rails_lite_app" }
      cookie ||= WEBrick::Cookie.new("_rails_lite_app", "test")
      cookie
    end
  end
end
