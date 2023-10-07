USE project3;

create table users
(
user_id	int primary key,
created_at 	varchar(20),
company_id	int,
`language` varchar(20),	
activated_at varchar(20),	
state varchar(20)
);
SELECT CAST(created_at AS DATETIME) AS converted_date
FROM users;
ALTER TABLE users MODIFY COLUMN created_at datetime NULL;
SHOW COLUMNS FROM users WHERE Field = 'created_at';

LOAD DATA INFILE "F:\Table-1 users.csv"
INTO TABLE users
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM USERS;

CREATE TABLE `events`
(
user_id	int,
occurred_at	varchar(20),
event_type varchar(30),
event_name  varchar(30)	,
location varchar(20)	,
device varchar(40),
user_type int null,
FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);
drop table `events`;
LOAD DATA INFILE "F:\Table-2 events.csv"
INTO TABLE `events`
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
ALTER TABLE `events` MODIFY COLUMN user_type varchar(2) NULL;
select * from `events`;

create table email_events
(
user_id	int null,
occurred_at varchar(30)	,
`action` varchar(30),
user_type int null,
foreign key (user_id) references users(user_id)
);
LOAD DATA INFILE "F:\Table-3 email_events.csv"
INTO TABLE `email_events`
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from email_events;

-- Calculate the weekly user engagement.

SELECT WEEK(STR_TO_DATE(created_at, '%Y-%m-%d')) AS week,
       COUNT(DISTINCT user_id) AS user_engagement
FROM users
GROUP BY week;


-- Calculate the user growth for the product:
SELECT WEEK(STR_TO_DATE(created_at, '%Y-%m-%d')) AS week,
       COUNT(DISTINCT user_id) AS user_growth
FROM users
GROUP BY week;

-- Calculate the weekly retention of users from the signup cohort
SELECT WEEK(STR_TO_DATE(created_at, '%Y-%m-%d')) AS week,
       COUNT(DISTINCT user_id) AS user_signup,
       COUNT(DISTINCT CASE WHEN state = 'active' THEN user_id END) AS user_retention
FROM users
GROUP BY week;

-- Calculate the weekly engagement per device
SELECT WEEK(STR_TO_DATE(e.occurred_at, '%Y-%m-%d')) AS week,
       e.device,
       COUNT(DISTINCT e.user_id) AS engagement
FROM events e
JOIN users u ON e.user_id = u.user_id
GROUP BY week, e.device;

-- Calculate the email engagement metrics
SELECT WEEK(STR_TO_DATE(occurred_at, '%Y-%m-%d')) AS week,
       COUNT(DISTINCT user_id) AS email_engagement
FROM email_events
GROUP BY week;
