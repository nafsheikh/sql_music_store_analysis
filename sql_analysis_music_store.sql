# Q1 : Who is the senior most employee based on job title ?

select * from employee
Order by levels desc
limit 1;


# Q2 : Which countries have the most Invoices ?

select COUNT(*) AS C, billing_country
from invoice
group by billing_country
order by C desc;


#Q3 : What are top 3 values of total invoice

Select total from invoice
order by total desc
limit 3;


# Which city has the best customers ? We would like to throw a promotional Music Festival in the city we made the most money.
# Write a query that returns one city that has the highest sum of invoice totals.
# Return both the city name & sum of all invoice totals. 

select sum(total) as invoice_total, billing_city
from invoice 
group by billing_city
order by invoice_total desc;


# Who is the best customer ? The customer who has spent the most money will be declared the best customer. 
# Write a query that returns the person who has spent the most money.  

SELECT customer.customer_id, customer.first_name, customer.last_name, 
       SUM(invoice.total) AS total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total DESC
LIMIT 1;


# WRITE QUERY TO RETURN THE EMAIL , FIRST NAME, LAST NAME, & GENRE OF ALL ROCK MUSIC LISTENERS.
# RETURN YOUR LISTED OREDERD ALPHABETICALLY BY EMAIL STARTING WITH A.

SELECT DISTINCT customer.email, customer.first_name, customer.last_name, genre.name AS genre
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock' 
AND customer.email LIKE 'A%'  -- Filters emails starting with 'A'
ORDER BY customer.email ASC;   -- Orders alphabetically by email


# Let's invite the artists who have written the most rock music in our dataset.
# Write a query that returns the Artist name and total track count of the top 10 rock bands..

SELECT artist.name AS artist_name, COUNT(track.track_id) AS total_tracks
FROM artist
JOIN album ON artist.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY total_tracks DESC
LIMIT 10;


# Q8: Return all the track names that have a song length longer than the average song length.
# Return the Name and Milliseconds for each track. Order by the song length with the longest songs
# listed first.

SELECT track.name AS track_name, track.milliseconds
FROM track
WHERE track.milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY track.milliseconds DESC;


# 9 Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent.

SELECT 
    customer.first_name || ' ' || customer.last_name AS customer_name, 
    artist.name AS artist_name, 
    SUM(invoice_line.unit_price * invoice_line.quantity) AS total_spent
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
GROUP BY customer.customer_id, customer_name, artist.artist_id, artist_name
ORDER BY customer_name, total_spent DESC;

