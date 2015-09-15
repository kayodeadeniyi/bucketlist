class Api::V1::UsersController < ApplicationController
  before_action :user_params only: [:create]

  def create
    @user = User.create(user_params)
  end

  def destroy
  end

  def update
  end

  def show
  end

  def index
  end

  private
    def user_params
      params.permit(:name, :email, :password)
    end

end
