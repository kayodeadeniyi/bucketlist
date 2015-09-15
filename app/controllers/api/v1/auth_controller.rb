class Api::V1::AuthController < ApplicationController
  before_action :authenticate, except:[:login]
  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      @user.update(login: true)
      render json: @user
    else
      response = {status: 'failure', body: 'Invalid login credential'}
      render json: response.to_json
    end
  end

  def logout
    authenticate_with_http_token do |token, options|
      @user = User.find_by(auth_token: token)
    end
    @user.update(login: false)
    response = {status: 'success', body: 'User logged out successfully'}
    render json: response.to_json
  end

  protected
    def auth_params
      params.permit(:email, :password)
    end

end
