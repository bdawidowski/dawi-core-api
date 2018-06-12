class ApiController < ApplicationController

  before_action :set_default_format
  before_action :authenticate_token!

  private
    def set_default_format
      request.format = :json
    end
    def authenticate_token!
      payload = JsonWebToken.decode(auth_token)
      @current_user = User.find(payload["did"])
    rescue JWT::ExpiredSignature
      render json: {errors: ["Auth token has expired"]}, status: :unauthorized
    rescue JWT::DecodeError
      render json: {errors: ["Invalid auth token"]}, status: :unauthorized
    end
    def auth_token
      headers = request.headers.fetch("Authorization", "")
      if headers
        return headers.split(' ').last
      else
        render json: {errors: ["No Token Found"]}, status: :unauthorized
      end
    end

end