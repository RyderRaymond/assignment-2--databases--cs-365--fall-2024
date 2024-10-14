/* Setup for the passwords database*/

DROP DATABASE IF EXISTS passwords;

CREATE DATABASE passwords;

DROP USER IF EXISTS 'passwords_db_user'@'localhost';

CREATE USER 'passwords_db_user'@'localhost' IDENTIFIED BY 'HVGyt789uIOJknbhvgytf&^89uionjk';
GRANT ALL PRIVILEGES ON passwords.*  TO 'passwords_db_user'@'localhost';

use passwords;


/* Set up encryption */

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('my secret passphrase', 256));
SET @init_vector = RANDOM_BYTES(16);


/* Create the tables for the database */

CREATE TABLE IF NOT EXISTS users (
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    user_id SMALLINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS websites (
    site_name VARCHAR(128) NOT NULL,
    url VARCHAR(256) UNIQUE NOT NULL,   -- UNIQUE because no two websites can have the same URL
    site_id SMALLINT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (site_id)
);

CREATE TABLE IF NOT EXISTS accounts (
    username VARCHAR(128) NOT NULL,
    password VARBINARY(512) NOT NULL,
    email_address VARCHAR(128) NOT NULL,
    user_id SMALLINT NOT NULL,  -- Relation to users table. Way to know which user this username and password is associated with.
    site_id SMALLINT NOT NULL,  -- Relation to websites table. Way to know what website this is associated with.
    comment VARCHAR(512),
    time_stamp DATETIME DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, site_id, username)  -- The same user cannot have a second account at the same website with the same username.
);



/* Insert values for the database */
INSERT INTO users (first_name, last_name) VALUES
    ('John', 'Smith'),
    ('Peter', 'Parker'),
    ('Satoru', 'Gojo'),
    ('Roy', 'Vanegas'),
    ('Carolyn', 'Rosiene');



INSERT INTO websites (site_name, url) VALUES
    ('Youtube', 'https://www.youtube.com/'),
    ('GitHub', 'https://github.com/'),
    ('Crunchyroll', 'https://www.crunchyroll.com/'),
    ('Uhart blackboard', 'https://blackboard.hartford.edu/');


INSERT INTO accounts (username, password, email_address, user_id, site_id, comment) VALUES
    ('jsmith', AES_ENCRYPT('5678JohnSmithIsTheBest62374uerfjncb', @key_str, @init_vector), 'jsmith@outlook.com', 1, 1, 'This will be the most epic youtube account ever.'),
    ('jsmith95', AES_ENCRYPT('4521485bestpassword*290', @key_str, @init_vector), 'jsmith@outlook.com', 1, 2, 'Going to make the best projects on github.'),
    ('not_spiderman2002', AES_ENCRYPT('ThisIsATotallySecurePassword', @key_str, @init_vector), 'pparker@live.com', 2, 1, NULL),
    ('the_honored_one', AES_ENCRYPT('8TurnedSidewaysisInfinity3729075', @key_str, @init_vector), 'honored_one@gmail.com', 3, 3, 'It might be a little difficult, but would I lose? Nah, I\'d win.');

