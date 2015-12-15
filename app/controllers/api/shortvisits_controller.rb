class API::ShortvisitsController < ApplicationController
  before_action :api_authenticate_user
  before_action :set_shortvisit, only: [:show, :geolocate]
  before_action :set_shorturl, only: [:index, :show, :geolocate]

  def geolocate
    if @current_user.id == @shorturl.user.id
      Shortvisit.geolocate(@shortvisit.id)
      render :show
    else
      render :json => {}, :status => :unprocessable_entity
    end
  end

  def index
    if @current_user.id == @shorturl.user.id
      @shortvisits = @shorturl.shortvisits
    else
      render :json => {}, :status => :unprocessable_entity
    end
  end

  def show
    if @current_user.id == @shorturl.user.id
      @shortvisits = @shorturl.shortvisits
    else
      render :json => {}, :status => :unprocessable_entity
    end
  end

  private

  def set_shortvisit
    @shortvisit = Shortvisit.find(params[:id])
  end

  def set_shorturl
    @shorturl = Shorturl.find(params[:shorturl_id])
  end

end
