class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.add_song(self)
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.find_by_name(name)
    all.find { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end

  def self.new_from_filename(file)
    file_array = file[/[^.]+/].split(' - ')
    song = Song.new(file_array[1])
    song.artist = Artist.find_or_create_by_name(file_array[0]).add_song(song)
    song.genre = Genre.find_or_create_by_name(file_array[2])
    song
  end

  def self.create_from_filename(file)
    song = new_from_filename(file)
    song.save
  end
end
