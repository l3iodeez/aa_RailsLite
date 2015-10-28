require_relative '../phase9/controller_base'
require_relative '../SQLObject'
require_relative '../AssocOptions.rb'

module Phase10
  class ControllerBase < Phase9::ControllerBase
    def form_authenticity_token
      @authenticity_token ||= SecureRandom::urlsafe_base64
      session[:authenticity_token] = @authenticity_token
    end
  end
end
