/*
Q1. Who is the senior most employee based on job title?
*/
SELECT (FIRST_NAME,
									LAST_NAME,
									LEVELS) AS SENIOR_MOST_EMPLOYEE
FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1;

/*
Q2. Which countries have the most Invoices?
*/
SELECT COUNT(*) AS NO_OF_INVOICES,
	BILLING_COUNTRY
FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY NO_OF_INVOICES DESC;

/*
Q3. What are top 3 values of total invoice?
*/
SELECT TOTAL AS TOP_3_VALUES
FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3;

/*
Q4. Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals
*/
SELECT BILLING_CITY,
	SUM(TOTAL) AS INVOICE_TOTAL
FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY SUM(TOTAL) DESC
LIMIT 1;

/*
Q5. Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most moneY
*/
SELECT CUSTOMER.CUSTOMER_ID,
	FIRST_NAME,
	LAST_NAME,
	SUM(TOTAL) AS TOTAL_SPENT
FROM CUSTOMER
JOIN INVOICE ON INVOICE.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID
ORDER BY TOTAL_SPENT DESC
LIMIT 1;

/*
Q6. Write query to return the email, first name, last name, & Genre of all Rock Music
listeners. Return your list ordered alphabetically by email starting with A
*/
SELECT DISTINCT(CUSTOMER.CUSTOMER_ID),
	EMAIL,
	FIRST_NAME,
	LAST_NAME,
	GENRE.NAME AS GENRE_NAME
FROM CUSTOMER
JOIN INVOICE ON INVOICE.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
JOIN INVOICE_LINE ON INVOICE_LINE.INVOICE_ID = INVOICE.INVOICE_ID
JOIN TRACK ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
WHERE GENRE.NAME LIKE 'Rock'
ORDER BY EMAIL;

/*
Q7. Let's invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands
*/ 
SELECT ARTIST.ARTIST_ID, 
	ARTIST.NAME, 
	COUNT(TRACK.TRACK_ID) AS TOTAL_COUNT
FROM TRACK
JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
JOIN ALBUM ON ALBUM.ALBUM_ID = TRACK.ALBUM_ID
JOIN ARTIST ON ARTIST.ARTIST_ID = ALBUM.ARTIST_ID 
WHERE GENRE.NAME LIKE 'Rock'
GROUP BY ARTIST.ARTIST_ID
ORDER BY TOTAL_COUNT DESC
LIMIT 10;

/*
Q8. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first
*/
SELECT TRACK_ID,
	TRACK.NAME,
	MILLISECONDS
FROM TRACK
WHERE MILLISECONDS >
		(SELECT AVG(MILLISECONDS) AS AVG_LENGTH
			FROM TRACK)
ORDER BY MILLISECONDS DESC;
