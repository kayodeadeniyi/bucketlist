class Api::V1::UsersController < ApplicationController
  before_action :authenticate, except:[:create]

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      response = {status: 'failure', body: 'User could not be created'}
      render json: response.to_json
    end
  end

  def show
    @user = User.find(current_user.id)
    render json: @user
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    response = {status: 'success', body: 'User deleted successfully'}
    render json: response.to_json
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    render json: @user
  end

  private
    def user_params
      params.permit(:name, :email, :password)
    end

end
