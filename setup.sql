/* Setup for the passwords database*/

DROP DATABASE IF EXISTS passwords;

CREATE DATABASE passwords;

DROP USER IF EXISTS 'passwords_db_user'@'localhost';

CREATE USER 'passwords_db_user'@'localhost' IDENTIFIED BY 'HVGyt789uIOJknbhvgytf&^89uionjk';
GRANT ALL PRIVILEGES ON passwords.*  TO 'passwords_db_user'@'localhost';

use passwords;


/* Set up encryption */

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('my secret passphrase', 512));
SET @init_vector = RANDOM_BYTES(16);


/* Create the tables for the database */

CREATE TABLE IF NOT EXISTS users (
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    id SMALLINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS websites (
    name VARCHAR(128) NOT NULL,
    url VARCHAR(256) NOT NULL,
    id SMALLINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS credentials (
    username VARCHAR(128) NOT NULL,
    password VARBINARY(512) NOT NULL,
    email_address VARCHAR(128) NOT NULL,
    user_id SMALLINT NOT NULL,  -- Relation to users table. Way to know which user this username and password is associated with.
    site_id SMALLINT NOT NULL,  -- Relation to websites table. Way to know what website this is associated with.
    comment VARCHAR(512),
    time_stamp DATETIME DEFAULT CURRENT_TIMESTAMP
);



/* Insert values for the database */
INSERT INTO users VALUES
    ('John', 'Smith'),
    ('Mark', 'Fishbach'),
    ('Peter', 'Parker'),
    ('Tony', 'Stark'),
    ('Chris', 'Evans'),
    ('Satoru', 'Gojo'),
    ('Suguru', 'Geto'),
    ('Roy', 'Vanegas'),
    ('Carolyn', 'Rosiene'),
    ('Olusola', 'Agboola');

INSERT INTO websites VALUES
    ('Youtube', 'https://www.youtube.com/');


INSERT INTO credentials VALUES
    ('jsmith', AES_ENCRYPT('5678JohnSmithIsTheBest62374uerfjncb', @key_str, @init_vector), 'jsmith@outlook.com', 1, 1, 'This will be the most epic youtube account ever')

