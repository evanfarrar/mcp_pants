class MapsController < ApplicationController
  
  def show
    map = Map.find(params[:id])
    if params[:zoomit]
      redirect_to map.zoomit_url(root_url)
    else
      redirect_to map.url(root_url)
    end
  end
end
