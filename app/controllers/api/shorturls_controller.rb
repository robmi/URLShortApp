class API::ShorturlsController < ApplicationController
  before_action :api_authenticate_user
  before_action :set_user, only: [:index, :show, :create, :destroy]
  before_action :set_shorturl, only: [:show, :destroy]

  def index
    if @current_user.id == @user.id
      @shorturls = @user.shorturls
    else
      render :json => {}, :status => :unprocessable_entity
    end
  end

  def show
    if @current_user.id == @user.id
      @shortvisits = @shorturl.shortvisits
    else
      render :json => {}, :status => :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shorturl
      @shorturl = Shorturl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shorturl_params
      params.require(:shorturl).permit(:original_url)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

end
