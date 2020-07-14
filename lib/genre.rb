class Genre

    extend Concerns::Findable

    attr_accessor :name, :artist, :song

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        Genre.new(name).tap do |genre|
        genre.save
        end
    end
    
    def songs
        @songs
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
        end

        if @songs.include?(song)
            nil 
          else @songs << song 
        end
    end

    def artists
        artist_arr = @songs.map {|song| song.artist}
        artist_arr.uniq
    end

end
