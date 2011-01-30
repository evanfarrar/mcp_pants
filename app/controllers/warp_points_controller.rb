class WarpPointsController < ApplicationController
  def create
    warp = WarpPoint.new(params[:warp_point])
    warp.save!
    flash[:notification] = "You will be kicked to get your coordinates. You may rejoin immediately"
    redirect_to player_path(warp.player)
  end
end
