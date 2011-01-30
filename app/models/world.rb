class World < ActiveRecord::Base
  def use
    Dir.mkdir("tmp/server/") unless File.directory?("tmp/server")
    File.open('tmp/server/server.properties', "w+") do |file|
      [:level_name,:hello_world,:spawn_monsters,:spawn_animals,
      :online_mode,:max_players,:pvp].each do |config|
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
    hours = system_time / 1000 + 6
    minutes = (((system_time % 1000) / 1000.0) * 60).to_i
    "#{hours}:#{"%02d" % minutes}"
  end

end
