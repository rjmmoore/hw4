class EntriesController < ApplicationController
  def new
    if @current_user.nil?
      flash["notice"] = "You must be logged in to add an entry."
      redirect_to "/login"
    end
  end

  def create
    if @current_user.nil?
      flash["notice"] = "You must be logged in to add an entry."
      redirect_to "/login"
    else
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @current_user["id"]
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    end
  end

  def edit
    @entry = Entry.find_by({ "id" => params["id"] })
  
    if @current_user.nil?
      flash["notice"] = "You must log in to edit an entry."
      redirect_to "/login"
    elsif @entry["user_id"] != @current_user["id"]
      flash["notice"] = "You are not authorized to edit this entry."
      redirect_to "/places"
    end
  end

  def update
    @entry = Entry.find_by({ "id" => params["id"] })

    if @current_user.nil? || @entry["user_id"] != @current_user["id"]
      flash["notice"] = "You are not authorized to update this entry."
      redirect_to "/places"
    else
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    end
  end

  def destroy
    @entry = Entry.find_by({ "id" => params["id"] })

    if @current_user.nil? || @entry["user_id"] != @current_user["id"]
      flash["notice"] = "You are not authorized to delete this entry."
      redirect_to "/places"
    else
      @entry.destroy
      flash["notice"] = "Entry deleted."
      redirect_to "/places/#{@entry["place_id"]}"
    end
  end
end

