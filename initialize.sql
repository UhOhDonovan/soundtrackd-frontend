DROP DATABASE IF EXISTS Soundtrackd;
DROP DATABASE IF EXISTS soundtrackd;
CREATE DATABASE soundtrackd;
USE soundtrackd;

CREATE TABLE USER(
    email VARCHAR(254) PRIMARY KEY,
    username VARCHAR(60) UNIQUE NOT NULL,
    password VARCHAR(64) NOT NULL
);

CREATE TABLE FOLLOWS_USER(
    follower VARCHAR(254),
    followed VARCHAR(254),
    PRIMARY KEY (follower, followed),
    CONSTRAINT fk_follower_email FOREIGN KEY (follower) REFERENCES USER(email),
    CONSTRAINT fk_followed_email FOREIGN KEY (followed) REFERENCES USER(email)
);

CREATE TABLE ARTIST(
    id VARCHAR(62) PRIMARY KEY,
    name VARCHAR(18) NOT NULL
);

CREATE TABLE FOLLOWS_ARTIST(
    user_id VARCHAR(254),
    artist_id VARCHAR(62),
    PRIMARY KEY (user_id, artist_id),
    CONSTRAINT follows_fk_user_id FOREIGN KEY (user_id) REFERENCES USER(email),
    CONSTRAINT follows_fk_artist_id FOREIGN KEY (artist_id) REFERENCES ARTIST(id)
);

CREATE TABLE ALBUM(
    id VARCHAR(62) PRIMARY KEY,
    title VARCHAR(25) NOT NULL,
    release_date DATE NOT NULL,
    artist_id VARCHAR(62) NOT NULL,
    CONSTRAINT album_fk_artist_id FOREIGN KEY (artist_id) REFERENCES ARTIST(id)
);

CREATE TABLE REVIEW(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    posted_by VARCHAR(254) NOT NULL,
    album_id VARCHAR(62) NOT NULL,
    post_date DATE NOT NULL,
    post_time TIME NOT NULL,
    rating INTEGER,
    body TEXT,
    CONSTRAINT review_fk_posted_by FOREIGN KEY (posted_by) REFERENCES USER(email),
    CONSTRAINT review_fk_album_id FOREIGN KEY (album_id) REFERENCES ALBUM(id)
);

CREATE TABLE REVIEW_COMMENT(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    review_id INTEGER NOT NULL,
    posted_by VARCHAR(254) NOT NULL,
    post_date DATE NOT NULL,
    post_time TIME NOT NULL,
    body TEXT,
    CONSTRAINT review_comment_fk_review_id FOREIGN KEY (review_id) REFERENCES REVIEW(id),
    CONSTRAINT review_comment_fk_posted_by FOREIGN KEY (posted_by) REFERENCES USER(email)
);

CREATE TABLE TRACK(
    id VARCHAR(62) PRIMARY KEY,
    title VARCHAR(23) NOT NULL,
    spotify_link VARCHAR(254) NOT NULL,
    artist_id VARCHAR(62),
    CONSTRAINT fk_artist_id FOREIGN KEY (artist_id) REFERENCES ARTIST(id)
);

CREATE TABLE TRACK_COMMENT(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    track_id VARCHAR(62) NOT NULL,
    posted_by VARCHAR(254) NOT NULL,
    post_date DATE NOT NULL,
    post_time TIME NOT NULL,
    body TEXT,
    CONSTRAINT track_comment_fk_track_id FOREIGN KEY (track_id) REFERENCES TRACK(id),
    CONSTRAINT track_comment_fk_posted_by FOREIGN KEY (posted_by) REFERENCES USER(email)
);

CREATE TABLE APPEARS_ON(
    track_id VARCHAR(62),
    album_id VARCHAR(62),
    track_num INTEGER NOT NULL,
    PRIMARY KEY (track_id, album_id),
    CONSTRAINT appears_on_fk_album_id FOREIGN KEY (album_id) REFERENCES ALBUM(id),
    CONSTRAINT appears_on_fk_track_id FOREIGN KEY (track_id) REFERENCES TRACK(id)
);