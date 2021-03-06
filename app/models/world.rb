class World < ActiveRecord::Base
  has_many :maps
  def self.configgables
    [:level_name,:hellworld,:allow_nether,
      :view_distance,:spawn_monsters,:online_mode,
      :spawn_animals,:max_players,:server_ip,:pvp,
      :level_seed,:server_port,:allow_flight,:white_list]
  end

  def use
    Dir.mkdir("tmp/server/") unless File.directory?("tmp/server")
    File.open('tmp/server/server.properties', "w+") do |file|
      World.configgables.each do |config|
        file << "#{config.to_s.dasherize}=#{self.send(config)}\n"
      end
    end
  end
  def self.current
    config_name = File.readlines('tmp/server/server.properties').grep(/^level-name=/).first.strip.split(/=/)[1]
    World.find_by_level_name(config_name)
  end

  SUNRISE = 0 # 6:00
  NOON = 6000 # 12:00
  SUNSET = 12000 # 18:00
  MIDNIGHT = 18000 # 24:00

  def system_epoch_time
    File.open("tmp/server/#{self.level_name}/level.dat") { |f| NBTFile.load(f).last["Data"]["Time"] }
  end

  def system_time
    system_epoch_time % 24000
  end

  def human_time
    hours = ((system_epoch_time + 6000) % 24000) / 1000
    minutes = (((system_time % 1000) / 1000.0) * 60).to_i
    "#{hours}:#{"%02d" % minutes}"
  end

  def path
    "tmp/server/#{self.level_name}"
  end

end
