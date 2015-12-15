class ShorturlsController < ApplicationController

  before_action :authorize!, except: :redirect_to_short
  before_action :set_user, only: [:index, :show, :new, :create, :destroy]
  before_action :set_shorturl, only: [:show, :destroy]

  def redirect_to_short

    # TODO: might be a rails increment function
    shorturl = Shorturl.find_by_shorturl(params[:id])
    shorturl.visits_count = shorturl.visits_count + 1
    shorturl.save

    remote_ip = request.remote_ip
    shortvisit = shorturl.shortvisits.build( ip: remote_ip)

    #TODO: log error if save fails
    shortvisit.save

    redirect_to(shorturl.original_url)
  end

  # TODO: authorize this page

  def index
    if current_user.id == @user.id
      @shorturls = @user.shorturls
    else
      flash[:error] = "Not authorized!."
      redirect_to root_path
    end
  end

  def show
    if current_user.id == @user.id
      @shortvisits = @shorturl.shortvisits
    else
      flash[:error] = "Not authorized!."
      redirect_to root_path
    end
  end

  def new
    if current_user.id == @user.id
      @shorturl = @user.shorturls.build
    else
      flash[:error] = "Not authorized!."
      redirect_to root_path
    end
  end

  # POST /shorturls
  # POST /shorturls.json
  def create
    if current_user.id == @user.id
      @shorturl = @user.shorturls.build(shorturl_params)
      respond_to do |format|
        if @shorturl.save
          format.html { redirect_to user_shorturl_path(@user, @shorturl), notice: 'Shorturl was successfully created.' }
          format.json { render :show, status: :created, location: @shorturl }
        else
          format.html { render :new }
          format.json { render json: @shorturl.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = "Not authorized!."
      redirect_to root_path
    end
  end

  # DELETE /shorturls/1
  # DELETE /shorturls/1.json
  def destroy
    if current_user.id == @user.id
      @shorturl.destroy

      respond_to do |format|
        format.html { redirect_to user_shorturls_path(@user), notice: 'Shorturl was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = "Not authorized!."
      redirect_to root_path
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
