class TeleportsController < ApplicationController
  def create
    tp = Teleport.new(:from => Player.find(params[:teleport][:from]),
                      :to => Player.find(params[:teleport][:to]))
    tp.perform
    redirect_to :back
  end
end
