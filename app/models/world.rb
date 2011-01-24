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
end
