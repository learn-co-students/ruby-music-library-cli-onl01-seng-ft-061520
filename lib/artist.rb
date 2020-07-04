class Artist
  attr_accessor :name, :song
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

  def add_song(song)
    if song.artist == nil
      song.artist = self
    else
      nil
    end
    if @songs.include?(song)
      nil
    else
      @songs << song
    end
  end

  def genres
    @n_a = []
    @songs.each do |song|
      if @n_a.include?(song.genre)
        nil
      else
        @n_a << song.genre
      end
    end
    @n_a
  end



end
