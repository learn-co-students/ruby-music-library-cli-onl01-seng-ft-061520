class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  def initialize(name)
    @name = name
    @@all << self
    @songs = []
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def self.create(name)
    genre = new(name)
    genre.save
    genre
  end

  def artists
    songs.collect{|song| song.artist}.uniq
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    @@all.clear
  end
end
