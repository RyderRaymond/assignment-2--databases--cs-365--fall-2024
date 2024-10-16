/*
File that contains the commands that are asked for in the introduction to the assignment.
*/


/*
Create a new entry into the database, which already has your 10 initial entries -------------------------------------------------------------------------------
*/

/* Create a new entry for a user */
INSERT INTO users (first_name, last_name) VALUES ('Chris', 'Hemsworth');

/* Create a new entry for a website */
INSERT INTO websites (site_name, url) VALUES ('Marvel', 'https://www.marvel.com/');

/* Create a new entry for a password */
INSERT INTO accounts (username, password, email_address, user_id, site_id, comment) VALUES
  ('thor_odinson', AES_ENCRYPT('#%ThePasswordForChrisHemsworthOrThor()*&', @key_str, @init_vector), 'chemsworth@marvel.com', 6, 6, 'This is a new account for Chris Hemsworth at Marvel Studios');


/*
Get the password associated with the URL of one of your 10 entries --------------------------------------------------------------------------------------------
*/

/* Gets the passwords from all entries which are to the website with url 'https://github.com/'*/
SELECT CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) AS 'Plain Text Password'
  FROM accounts
  JOIN websites
  USING (site_id)
  WHERE url = 'https://github.com/';


/*
Get all the password-related data, including the password, associated with URLs that have https in two of your 10 entries -------------------------------------
*/

/* For my example, password-related data may refer to account information. This command gets the information associated with all accounts associated with URLs that have https*/
