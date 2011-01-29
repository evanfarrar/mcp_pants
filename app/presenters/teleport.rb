class Teleport
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :from, :to, :warp_point
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end

  def perform
    if self.warp_point
      from.warp(warp_point.coords)
    else
      ServerWrapper.run_remote("tp #{from.name} #{to.name}")
    end
  end
end
