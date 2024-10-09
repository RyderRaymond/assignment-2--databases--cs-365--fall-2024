/* Setup for the passwords database*/

DROP DATABASE IF EXISTS passwords;

CREATE DATABASE passwords;

DROP USER IF EXISTS 'passwords_db_user'@'localhost';

CREATE USER 'passwords_db_user'@'localhost' IDENTIFIED BY 'HVGyt789uIOJknbhvgytf&^89uionjk';
GRANT ALL PRIVILEGES ON passwords.*  TO 'passwords_db_user'@'localhost';

use passwords;


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



/* Insert values for the database */
