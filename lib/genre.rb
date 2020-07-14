class Genre 

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
    self.new(name).tap do |genre|
      genre.save  
    end
  end

  def songs 
    @songs 
  end

  def artists
    @new_array = []
    @songs.each do |song|
      if @new_array.include?(song.artist)
        nil
      else
        @new_array << song.artist
      end
    end
    @new_array
  end


end