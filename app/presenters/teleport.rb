class Teleport
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :from, :to
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end


  def perform
    HTTParty.post("http://127.0.0.1:4567/", 
      :body => {:command => "tp #{from.name} #{to.name}"})
  end
end
