create database if not exists music_database;
use music_database;

create table album(
album_id int primary key,
title varchar(60),
artist_id int,
foreign key (artist_id) references artist(artist_id)
);

create table artist(
artist_id int primary key,
`artist_name` varchar(100)
);


create table customer(
customer_id int primary key,
first_name varchar(30),
last_name varchar(30),
company varchar(100),
address varchar(200),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code varchar(20),
phone varchar(30),fax varchar(30),
email	varchar(30),
support_rep_id int,
foreign key(support_rep_id) references employee(employee_id)
);
drop table employee;
create table employee(
employee_id int not null primary key,
first_name varchar(30),
last_name varchar(20),
title varchar(30),
reports_to varchar(3),
levels varchar(5),
birthdate varchar(20),
hire_date varchar(20),
address varchar(50),
city varchar(20),
state varchar(20),
country varchar(20),
postal_code	varchar(30),
phone varchar(30),
fax varchar(20),
email varchar(40)
);

create table genre(
genre_id int,
name varchar(60)
);

create table invoice(
invoice_id int not null primary key,
customer_id int,
invoice_date varchar(30),
billing_address varchar(50),
billing_city varchar(30),
billing_state varchar(30),
billing_country	varchar(40),
billing_postal_code	varchar(40),
total float,
foreign key (customer_id) references customer(customer_id)
);

create table invoice_line(
invoice_line_id	int not null primary key,
invoice_id int,
track_id	int,
unit_price float, 
quantity int,
foreign key (invoice_id) references invoice(invoice_id),
foreign key (track_id) references track(track_id)
);

create table media_type(
media_type_id int primary key,
`name` varchar(60)
);

create table playlist(
playlist_id	int not null primary key,
`name` varchar(50) 
);

create table playlist_track(
playlist_id	int,
track_id int,
foreign key (playlist_id) references playlist(playlist_id),
foreign key (track_id) references track(track_id)
);

create table track(
track_id int primary key,
`name` varchar(100),
album_id int,
media_type_id int,
genre_id int,
composer varchar(100),
milliseconds int,
bytes int,
unit_price float,
foreign key(album_id) references album(album_id),
foreign key(media_type_id) references media_type(media_type_id),
foreign key(genre_id) references genre(genre_id)
);

LOAD DATA INFILE "F:\track.csv"
INTO TABLE `track`
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
drop table track;
ALTER TABLE genre
ADD INDEX genre_id_index (genre_id);







