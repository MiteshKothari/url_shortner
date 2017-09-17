class ShortenersController < ApplicationController

  def index
    @shorteners = Shortener.order(hits: :desc)
    @shortener = Shortener.new
  end

  # creating new shortner record
  def create
    @shortener = Shortener.where(target: shortener_params[:target]).first_or_initialize
    respond_to do |format|
      if @shortener.save!
        format.html { redirect_to root_path, notice: 'Shortner was successfully created.' }
      else
        format.js
        format.json { render json: @shortener.errors, status: :unprocessable_entity }
      end
    end
  end

  # increments count of hit for hitted url
  def deflect
    if params[:dilute]
      @shortner = Shortener.find_by(dilute: params[:dilute])
      if(redirect_to @shortner.target?)
        @shortner.hits += 1
        @shortner.save
      end
    end
  end

  private
    # allowed params
    def shortener_params
      params.require(:shortener).permit(:target)
    end
end
