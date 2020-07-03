class Artist 
  attr_accessor :name 
  attr_reader :genre, :song 
  
  @@all = [] 
  
  def initialize(name)
    @name = name
  end 
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    all.clear 
  end
  
  def save 
    self.class.all << self 
  end 
  
  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end 
  
end 