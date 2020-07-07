class MusicImporter
  attr_accessor :path
  @files = []

  def initialize(path)
    @path = path
    save
  end

  def save
    @files = Dir.glob("*.mp3", base: "#{path}")
  end
  
  def files
    @files
  end

  def import
    files.each do |file| 
      Song.create_from_filename(file)
    end
  end
end
