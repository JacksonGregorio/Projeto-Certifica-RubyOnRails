class AuthenticationController < ApplicationController

    before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.username, type: @user.type_user, company: @user.company}, status: :ok
    else
      json_response(error: 'unauthorized' , status: :unauthorized)
    end
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
  
end
