class Artist 

  attr_accessor :name 

  @@all = []
  extend Concerns::Findable

  def initialize(name, songs = []) 
    @name = name 
    @songs = songs 
  end

  def self.all 
    @@all 
  end

  def self.destroy_all 
    self.all.clear 
  end

  def save 
    @@all << self 
  end

  def self.create(name)
    self.new(name).tap do |artist|
      artist.save
    end
  end

  def songs 
    @songs 
  end

  def add_song(song)
    song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
  end

  def genres
    @new_array = []
    @songs.each do |song|
      if @new_array.include?(song.genre)
        nil
      else
        @new_array << song.genre
      end
    end
    @new_array
  end


end