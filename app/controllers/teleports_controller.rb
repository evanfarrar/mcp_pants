class TeleportsController < ApplicationController
  def create
    if params[:teleport][:to]
      from = Player.find(params[:teleport][:from])
      to = Player.find(params[:teleport][:to])
      tp = Teleport.new(:from => from, :to => to)
      tp.perform
      flash[:notification] = "Teleporting you to #{to}"
    elsif params[:teleport][:warp_point]
      tp = Teleport.new(:from => Player.find(params[:teleport][:from]),
                        :warp_point => WarpPoint.find(params[:teleport][:warp_point]))
      tp.perform
      flash[:notification]
    end
    redirect_to :back
  end
end
