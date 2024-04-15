use music_database;

# 1. Who is the senior most employee based on job title?

select * from employee;
select distinct reports_to from employee;
select employee_id,first_name,title
from employee
where reports_to = 0;

# 2. Which countries have the most Invoices?

select * from invoice;
select billing_country, count(billing_country) as Total_invoice
from invoice
group by billing_country
order by 2 desc limit 5;

# 3. What are top 3 values of total invoice?

select invoice_id, total
from invoice
order by 2 desc limit 3;

select billing_country, count(billing_country) as Total_invoice,
round(sum(total),0) as Total_value
from invoice
group by billing_country
order by 2 desc limit 5;

# 4. Which city has the best customers? 
		/* We would like to throw a promotional Music Festival in the city we made the most money.
        Write a query that returns one city that has the highest sum of invoice totals.
        Return both the city name & sum of all invoice totals */

select billing_city, sum(total) as total_invoice_value
from invoice
group by billing_city
order by 2 desc limit 1;

# 5. Who is the best customer? 
	/* The customer who has spent the most money will be declared the best customer. 
    Write a query that returns the person who has spent the most money */
    
select * from customer;
select * from invoice;

select i.customer_id, c.first_name ,round(sum(i.total),0) as total_spent
from invoice i
inner join customer c
on i.customer_id = c.customer_id
group by i.customer_id
order by total_spent desc;

-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A 

select * from customer;
select * from invoice;
select * from genre;
select * from invoice_line;
select * from track;

/* Method 1 */
select email, first_name, last_name
from customer where customer_id in (
select customer_id from invoice where invoice_id in(
select invoice_id from invoice_line where track_id in(
select track_id
from track where genre_id = 1)))
order by email;

/* Method 2*/
select distinct c.email, c.first_name, c.last_name
from customer c 
join invoice i on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join genre g on g.genre_id = t.genre_id
order by c.email;

-- 2. Let's invite the artists who have written the most rock music in our dataset. 
	-- Write a query that returns the Artist name and total track count of the top 10 rock bands
    
select * from artist;
select * from genre;
select * from track;   -- album id join album
select * from album;   -- artist id join artist

select a.artist_name, count(t.track_id) as total_track
from artist a
join album al on al.artist_id = a.artist_id
join track t on t.album_id = al.album_id
join genre g on g.genre_id = t.genre_id
where g.`name` = 'Rock'
group by a.artist_name
order by total_track desc limit 10;









