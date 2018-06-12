class Api::V1::AuthenticationController < ApiController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:email], params[:password])
      render json: {token: JsonWebToken.encode(did: user.did)}, status: :success
    else
      render json: {errors: ["Invalid email or password"]}, status: :unautherized
    end
  end
end
