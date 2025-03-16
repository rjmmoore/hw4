class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })

    if @current_user
      @entries = Entry.where({ "place_id" => @place["id"], "user_id" => @current_user["id"] }) # Only show current user's entries
    else
      @entries = [] # Show no entries if logged out
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

