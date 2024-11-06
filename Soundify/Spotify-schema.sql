-- create 'User' table
CREATE TABLE User (
    userID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(20) NOT NULL,
    subscriptionType VARCHAR(7) DEFAULT 'free',
    followers INT
);
-- create 'Genre' table
CREATE TABLE Genre (
    genreID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    genreName VARCHAR(20),
    genreDescription VARCHAR(250)
);
-- create 'Artist' table
CREATE TABLE Artist (
    artistID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    artistName VARCHAR(20),
    genreID INT NOT NULL,
    FOREIGN KEY (genreID) REFERENCES Genre(genreID)
);
-- create 'Followers' table
CREATE TABLE Followers (
    followID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    artistID INT NOT NULL,
    followDate DATE,
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (artistID) REFERENCES Artist(artistID)
);
-- create 'Album' table
CREATE TABLE Album (
    albumID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    albumName VARCHAR(30) NOT NULL,
    releaseDate DATE,
    artistID INT NOT NULL,
    genreID INT NOT NULL,
    FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    FOREIGN KEY (genreID) REFERENCES Genre(genreID)
);
-- create 'Song' table
CREATE TABLE Song (
    songID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    albumID INT NOT NULL,
    duration INT NOT NULL,
    artistID INT NOT NULL,
    genreID INT NOT NULL,
    numLiKES INT,
    FOREIGN KEY (albumID) REFERENCES Album(albumID),
    FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    FOREIGN KEY (genreID) REFERENCES Genre(genreID)
);
-- create 'Song Likes' table
CREATE TABLE Song_likes (
    songLikeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    songID INT NOT NULL,
    songLikeDate DATE,
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (songID) REFERENCES Song(songID)
);
-- create 'Playlist' table
CREATE TABLE Playlist (
    playlistID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    playlistName VARCHAR(30),
    creationDate DATE,
    FOREIGN KEY (userId) REFERENCES User(userID)
);
-- create 'Playlist Song' table
CREATE TABLE Playlist_song (
    playlistSongID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    playlistID INT NOT NULL,
    songID INT NOT NULL,
    FOREIGN KEY (playlistID) REFERENCES Playlist(playlistID),
    FOREIGN KEY (songID) REFERENCES Song(songID)
);
-- create 'Podcast' table
CREATE TABLE Podcast (
    podcastID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    podcastTitle VARCHAR(30),
    description VARCHAR(250),
    artistID INT NOT NULL,
    releaseDate DATE,
    genreID INT NOT NULL,
    FOREIGN KEY (artistID) REFERENCES Artist(artistID),
    FOREIGN KEY (genreID) REFERENCES Genre(genreID)
);
-- create 'Podcast Episode' table
CREATE TABLE Podcast_episode (
    episodeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    podcastID INT NOT NULL,
    uploadDate DATE,
    duration INT NOT NULL,
    numLikes INT,
    FOREIGN KEY (podcastID) REFERENCES Podcast(podcastID)
);
-- create 'Podcast Likes' table
CREATE TABLE Podcast_likes (
    podcastLikeID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID INT NOT NULL,
    podcastID INT NOT NULL,
    podcastLikeDate DATE,
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (podcastID) REFERENCES Podcast(podcastID)
);