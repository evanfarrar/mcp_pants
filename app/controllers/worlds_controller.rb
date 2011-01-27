class WorldsController < ApplicationController
  def index
    @worlds = World.all
  end

  def new
    @world = World.new
  end

  def edit
    @world = World.find(params[:id])
  end

  def create
    @world = World.create!(params[:world])
    flash[:notification] = "#{@world.level_name} created successfully."
    redirect_to worlds_path
  end

  def show
    world = World.find(params[:id])
    logger.error `c10t -w tmp/server/#{world.level_name} -o public/images/worlds/#{world.id}.png -z -M 256`
    redirect_to "/images/worlds/#{world.id}.png"
  end

  def update
    @world = World.find(params[:id])
    if params[:world][:use]
      @world.use
      flash[:notification] = "#{@world.level_name} now the active world."
    end
    if params[:world].except!(:use).any?
      @world.update_attributes!(params[:world])
      flash[:notification] = "#{@world.level_name} updated successfully."
    end
    redirect_to worlds_path
  end

  def destroy
    #rmdir (if it is the last world with this name)
  end
end
