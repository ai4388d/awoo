DROP DATABASE IF EXISTS awoo;
CREATE DATABASE awoo;
GRANT ALL ON awoo.* TO awoo@'%' IDENTIFIED BY 'awoo';
USE awoo;
CREATE TABLE posts (
	board TEXT NOT NULL,
	post_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	parent INTEGER DEFAULT NULL,
	content TEXT NOT NULL,
	ip TEXT DEFAULT NULL,
	is_locked BOOL DEFAULT FALSE,
	date_posted TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	title TEXT NOT NULL DEFAULT ''
);
