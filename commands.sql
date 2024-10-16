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

/* Create a new entry for a password to the previous user and website */
INSERT INTO accounts (username, password, email_address, user_id, site_id, comment) VALUES
  ('thor_odinson', AES_ENCRYPT('#%ThePasswordForChrisHemsworthOrThor()*&', @key_str, @init_vector), 'chemsworth@marvel.com', 6, 6, 'This is a new account for Chris Hemsworth at Marvel Studios');


/*
Get the password associated with the URL of one of your 10 entries --------------------------------------------------------------------------------------------
*/

/* Gets the passwords from all entries which are to the website with url 'https://github.com/'*/
SELECT CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) AS 'Plain Text Password'
  FROM accounts
  JOIN websites USING (site_id)
  WHERE url = 'https://github.com/';


/*
Get all the password-related data, including the password, associated with URLs that have https in two of your 10 entries -------------------------------------

NOTE: I used https URLs for most of the websites, so I made blackboard an http URL to demonstrate this command.
*/

/*
For my database, password-related data may refer to the accounts table's information only, not user and website information.
This command gets only fields from the account tuples that are associated with websites whose URLs contain 'https'.

We have to explicitly state everything we want to select, so that we can decrypt the password to plain text.
Replace with SELECT accounts.* for all account-related information, with encrypted passwords.
*/
SELECT accounts.username,
  CAST(AES_DECRYPT(accounts.password, @key_str, @init_vector) AS CHAR) AS 'Plain Text Password',
  accounts.email_address,
  accounts.user_id,
  accounts.site_id,
  accounts.comment,
  accounts.time_stamp
  FROM accounts
  JOIN websites USING (site_id)
  WHERE url LIKE 'https%';


/*
If password-related data includes data from all tuples related to this tuple,
this command gets information from all related tuples that are associated with websites whose URLs contain 'https'.

Rather than using SELECT *, we have to explicitly state what we want so that we can decrypt the password.
Replace with SELECT * FROM accounts... for everything and encrypted passwords.
*/
SELECT accounts.username,
  CAST(AES_DECRYPT(accounts.password, @key_str, @init_vector) AS CHAR) AS 'Plain Text Password',
  accounts.email_address,
  accounts.user_id,
  accounts.site_id,
  accounts.comment,
  accounts.time_stamp,
  users.*,
  websites.*
  FROM accounts
  JOIN users USING (user_id)
  JOIN websites USING (site_id)
  WHERE url LIKE 'https%';


/*
Change a URL associated with one of the passwords in your 10 entries ------------------------------------------------------------------------------------------
*/

/* Updates the website that is associated with an account that has password '2"dG1Y6v,TdRz4-5D|bzWR~U?=][_'. This will update Netflix. */
UPDATE websites, accounts
  SET websites.url = 'https://netflix.com/library'
  WHERE websites.site_id = accounts.site_id
  AND CAST(AES_DECRYPT(accounts.password, @key_str, @init_vector) AS CHAR) = '2"dG1Y6v,TdRz4-5D|bzWR~U?=][_';



/*
Change any password -------------------------------------------------------------------------------------------------------------------------------------------
*/

UPDATE accounts
  SET password = AES_ENCRYPT('&#(@SettingANewPassword5123', @key_str, @init_vector)
  WHERE username = 'rosiene';


/*
Remove a tuple based on a URL ---------------------------------------------------------------------------------------------------------------------------------
*/

/* Deletes the website, and due to the foreign key, deletes accounts for this website (the account associated with username 'the_honored_one') */
DELETE FROM websites WHERE url = 'https://www.crunchyroll.com/';


/*
Remove a tuple based on a password ----------------------------------------------------------------------------------------------------------------------------
*/

/* Deletes Professor Vanegas' UHART account */
DELETE FROM accounts WHERE CAST(AES_DECRYPT(accounts.password, @key_str, @init_vector) AS CHAR) = 'qK13*M29 S0HL&aMGFQ{MsN6<^T{o_';
