class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []
  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    if @songs.include?(song)
      nil
    else
      @songs << song
    end
    song
  end

  def genres
    songs.collect{|song| song.genre}.uniq
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
