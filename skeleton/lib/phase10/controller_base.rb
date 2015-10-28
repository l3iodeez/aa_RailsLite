module Phase10
  class ControllerBase < Phase9::ControllerBase
    def form_authenticity_token
      @auth_token ||= SecureRandom::urlsafe_base64
      session[:auth_token] = @auth_token
    end
  end
end
