class Api::V1::RegistrationController < ApiController
  skip_before_action :authenticate_token!, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: {token: JsonWebToken.encode(did: user.did)}, status: :success
    else
      render json: {errors: ["Unable to create an account."]}, status: :unautherized
    end
  end
  private
    def user_params
      params.permit(:email, :password)
    end
end