class WarpPoint < ActiveRecord::Base
  belongs_to :player

  before_save :set_coords
  
  def coords
    [self.x, self.y, self.z]
  end

private
  def set_coords
    self.player.kick
    unless self.x && self.y && self.z
      self.x, self.y, self.z = self.player.position
    end
    true
  end
end
