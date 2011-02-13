class MotdsController < ApplicationController
  def create
    Motd.create!(:body => params[:body], :creator => params[:creator])
    render :text => params[:body]
  end
end
