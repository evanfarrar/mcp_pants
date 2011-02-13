class Map < ActiveRecord::Base
  belongs_to :world

  after_create :write_map_file

  def write_map_file
    Dir.mkdir("public/images/maps") unless File.directory?("public/images/maps")
    logger.error `c10t -w #{world.path} -o public#{self.path} -z -M 256`
  end

  def path
    "/images/maps/#{self.id}.png"
  end

  def url(root_url)
    "#{root_url}images/maps/#{self.id}.png"
  end

  def zoomit_url(root_url)
    "http://zoom.it/?url=#{self.url(root_url)}"
  end
end
