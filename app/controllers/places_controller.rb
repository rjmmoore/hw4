class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
  
    if @place.nil?
      flash["notice"] = "Place not found."
      redirect_to "/places"
    else
      if @current_user
        @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"] })
      else
        @entries = []
      end
    end
  end

  def new
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end

