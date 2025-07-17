--which country has most invoice--
select count(*) as c, billing_country
from invoice
group by billing_country
order by c desc;

--what are top 3 values of total_invoice--
select total from invoice
order by total desc
limit 3;

--write a query that returns one city that has highst sum
select billing_city, sum(total) as totals
from invoice
group by billing_city
order by totals desc
limit 1;

-- find the best cutomer who sped most money--

select customer.customer_id, customer.first_name, customer,last_name , sum(invoice.total) as total
from customer
inner join 
invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1;


--moderate questions--

SELECT DISTINCT 
  customer.first_name, 
  customer.last_name, 
  customer.email
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoiceline ON invoice.invoice_id = invoiceline.invoice_id
WHERE track_id IN (
  SELECT track_id 
  FROM track
  JOIN genre ON track.genre_id = genre.genre_id
  WHERE genre.name = 'Rock'
)
ORDER BY email; 

--question 2
select artist.artist_id, artist.name , count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.album_id
join genre on genre.genre_id = track.genre_id
where genre.name = 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;

--question 3
select name, milliseconds from track
where milliseconds > (
					select avg(milliseconds) as avg_track_length  from track)
order by milliseconds  desc;

--Advance questions 


with best_selling_artist as(
		select artist.artist_id as artist_id, artist.name as artist_name,
		sum(invoice_line.unit_price*invoice_line.quantity) as total_Sales 
		from invoice_line
		join track on track.track_id = invoice_line.track_id
		join album on album.album_id = track.ablum_id
		join artist on artist.artist_id = album.artist_id
		group by 1
		order by 3 desc
		limit 1;
)
select c.customer_id, c.first_name,bsa.artist_name, 
sum(il.unit_price*il.quantity) as amount_spent
from invoice i 
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id

