require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params

    # setup the controller
    def initialize(req, res, route_params = {})
      super(req, res)
      @params = Params.new(req, route_params)

      if req.request_method == "POST"
        raise "Invalid Authenticity Token" unless session["authenticity_token"] == params[:authenticity_token]
      end
    end
  end
end
