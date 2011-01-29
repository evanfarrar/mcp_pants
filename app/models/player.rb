class Player < ActiveRecord::Base
  has_many :chat_messages

  def nbt_file
    "tmp/server/#{World.current.level_name}/players/#{self.name}.dat"
  end

  def nbt_data
    NBTFile.load(File.read(self.nbt_file))
  end

  def warp(coords)
    tokes = NBTFile.tokenize(File.open(self.nbt_file))
    start_pos = tokes.index{|t| t.name == "Pos"} + 1
    tokes[start_pos...(start_pos+4)].each_with_index do |e,i|
      e.value = coords[i]
    end
    ServerWrapper.run_remote("kick #{self.name}")
    sleep(0.1)
    NBTFile.emit(File.open(self.nbt_file, "w+")) do |writer|
      tokes.each do |t|
        writer.emit_token(t)
      end
    end
  end

  def position
    nbt_data[1]["Pos"]
  end

  def kick
    ServerWrapper.run_remote("kick #{self.name}")
  end
end
