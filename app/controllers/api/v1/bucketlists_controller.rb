class Api::V1::BucketlistsController < ApplicationController
  before_action :authenticate, except:[:index]

  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, each_serializer: BucketlistsimpleSerializer#, root: false
  end

  def create
    @bucketlist = Bucketlist.new(bucketlist_params)
    @bucketlist.user_id = current_user.id
    if @bucketlist.save
      render json: @bucketlist
    else
      response = {status: 'failure', body: 'Bucketlist could not be created'}
      render json: response.to_json
    end
  end

  def update
    @bucketlist = Bucketlist.find(params[:id])
    if @bucketlist.try(:user_id) == current_user.id
      @bucketlist.update(bucketlist_params)
      render json: @bucketlist
    else
      response = {status: 'failure', body: 'You can only update bucketlists that you created'}
      render json: response.to_json
    end
  end

  def show
    @bucketlist = Bucketlist.find(params[:id])
    if @bucketlist.try(:user_id) == current_user.id
      render json: @bucketlist
    else
      response = {status: 'failure', body: 'You can only see bucketlists that you created'}
      render json: response.to_json
    end
  end

  def destroy
    @bucketlist = Bucketlist.find(params[:id])
    if @bucketlist.try(:user_id) == current_user.id
      @bucketlist.destroy
      response = {status: 'success', body: 'Bucketlist deleted successfully'}
      render json: response.to_json
    else
      response = {status: 'failure', body: 'You can only destroy bucketlists that you created'}
      render json: response.to_json
    end
  end

  def add_item
    @bucketlist = Bucketlist.find(params[:id])
    if @bucketlist.try(:user_id) == current_user.id
      @item = Item.new(item_params)
      @item.bucketlist_id = params[:id]
      if @item.save
        render json: @item
      else
        response = {status: 'failure', body: 'Item could not be created'}
        render json: response.to_json
      end
    else
      response = {status: 'failure', body: 'You can only add items to bucketlists that you created'}
      render json: response.to_json
    end
  end

  protected
    def bucketlist_params
      params.permit(:name)
    end

    def item_params
      params.permit(:name, :done)
    end

end
