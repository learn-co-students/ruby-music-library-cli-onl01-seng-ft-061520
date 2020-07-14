class Song

    attr_accessor :name, :artist, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist)
        self.genre=(genre)
    end

    def self.all
        @@all
    end
    
    def save 
        @@all << self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(name)
        Song.new(name).tap do |song|
        song.save
        end
    end

    def artist 
        @artist
    end

    def artist=(artist)
        if artist != nil
            @artist = artist
            artist.add_song(self)
        end
    end

    def genre
        @genre
    end
   
    def genre=(genre)
     
        if genre != nil
            @genre = genre
            genre.songs << self unless genre.songs.include?(self)
           
        end
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name}
    end

    def self.find_or_create_by_name(name) 
        if find_by_name(name) == nil
            self.create(name)
        else
            find_by_name(name)
        end
    end

    def self.new_from_filename(filename)
        artist_name = filename.split(" - ")[0]
        song_name = filename.split(" - ")[1]
        genre_name = filename.split(" - ")[2].chomp(".mp3")
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name)
        self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end
end
