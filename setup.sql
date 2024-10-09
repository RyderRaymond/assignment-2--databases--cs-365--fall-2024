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
    id SMALLINT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS websites (
    name VARCHAR(128) NOT NULL,
    url VARCHAR(256) NOT NULL,
    id SMALLINT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS credentials (
    username VARCHAR(128) NOT NULL,
    password VARBINARY(512) NOT NULL,
    email_address VARCHAR(128) NOT NULL,
    user_id SMALLINT NOT NULL,  --relation to users table. Way to know which user this username and password is associated with.
    site_id SMALLINT NOT NULL,  --relation to websites table. Way to know what website this is associated with.
    comment VARCHAR(512),
    timestamp DATE NOT NULL
);



/* Insert values for the database */
