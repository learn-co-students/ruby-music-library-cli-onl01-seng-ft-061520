class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).select! {|entry| entry.end_with?(".mp3")}
  end

  def import
    self.files.each do |name|
      Song.create_from_filename(name)
    end
  end 


end
