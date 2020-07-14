class Artist

    extend Concerns::Findable

    attr_accessor :name, :songs
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
        Artist.new(name).tap do |artist|
        artist.save
        end
    end
    
    def songs
        @songs
    end
    
    def add_song(song)
        if song.artist == nil
            song.artist = self
        end

        if @songs.include?(song)
            nil 
          else @songs << song 
        end
    end

    def genres
       genres_arr = @songs.map {|song| song.genre}
       genres_arr.uniq
    end


end
