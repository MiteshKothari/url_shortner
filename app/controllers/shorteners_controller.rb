class ShortenersController < ApplicationController

  def index
    @shorteners = Shortener.order(hits: :desc)
    @shortener = Shortener.new
  end

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

  def deflect
    if params[:dilute]
      @shortner = Shortener.find_by(dilute: params[:dilute])
      if(redirect_to @shortner.target?)
        @shortner.hits += 1
        @shortner.save
      end
    end
  end

  def find
    shorteners = Shortener.where("target ilike :target", target: params[:target])
    respond_to do |format|
      format.json {render  json: shorteners}
    end
  end

  private
    def shortener_params
      params.require(:shortener).permit(:target)
    end
end
