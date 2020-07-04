class Genre
  attr_accessor :name
  extend Concerns::Findable
  
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(song)
    song = self.new(song)
    song.save
    song
  end

  def songs
    @songs
  end

  def artists
    @n_a = []
    @songs.each do |song|
      if @n_a.include?(song.artist)
        nil
      else
        @n_a << song.artist
      end
    end
    @n_a
  end



end
