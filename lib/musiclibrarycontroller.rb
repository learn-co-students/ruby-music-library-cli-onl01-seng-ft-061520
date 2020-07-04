class MusicLibraryController
  attr_accessor :path

  def initialize(path='./db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end

  def call
    input = gets.strip
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      when "exit"
        'exit'
      else
        call
      end
    end

    def library(klass = Song)
    sorted_library = klass.all.collect{|o| o if o.class == klass }
    sorted_library = sorted_library.delete_if {|o| o == nil}
    sorted_library.uniq
  end

    def list_songs
    sorted_library = self.library.sort_by {|s| s.name}
    sorted_library.each do |s|
      puts "#{sorted_library.index(s) + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    sorted_library = self.library(Artist).sort_by {|o| o.name}
    artists = sorted_library.collect {|o| "#{o.name}"}.uniq
    artists.each {|artist| puts "#{artists.index(artist) + 1}. #{artist}"}
  end

  def list_genres
    sorted_library = self.library.sort_by {|s| s.genre.name}
    genres = sorted_library.collect {|s| "#{s.genre.name}"}.uniq
    genres.each {|g| puts "#{genres.index(g) + 1}. #{g}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    artist_songs = []
    self.library.each do |s|
      if s.artist.name == input
        artist_songs << s
      end
    end
    artist_songs = artist_songs.sort_by{|s| s.name}
    artist_songs.each {|s| puts "#{artist_songs.index(s) + 1}. #{s.name} - #{s.genre.name}"} unless artist_songs == nil
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre_songs = []
    self.library.each do |s|
      if s.genre.name == input
        genre_songs << s
      end
    end
    genre_songs = genre_songs.sort_by{|s| s.name}
    genre_songs.each {|s| puts "#{genre_songs.index(s) + 1}. #{s.artist.name} - #{s.name}"} unless genre_songs == nil
  end

  def play_song
    puts "Which song number would you like to play?"
    song_names = self.song_array
    input = gets.strip.to_i
    if input > 0 && input <= self.library.size
      chosen_input = song_names[input - 1]
      chosen_input = name_extractor(chosen_input)[1]
      song = Song.find_by_name(chosen_input)
      puts "Playing #{song.name} by #{song.artist.name}" unless song == nil
    end
  end

  def song_array
    sorted_library = self.library.sort_by {|s| s.name}
    sorted_library.collect do |s|
      "#{sorted_library.index(s) + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def name_extractor(name)
    file_bits = name.gsub(/\.mp3/,' ')
    file_bits = file_bits.split(" - ")
  end

end
