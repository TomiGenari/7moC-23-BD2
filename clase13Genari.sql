USE sakila;

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (2, 'Alice', 'Smith', 'alice.smith@gmail.com',
        (SELECT MAX(address_id)
         FROM address
         WHERE city_id IN (SELECT city_id
                          FROM city
                          WHERE country_id IN (SELECT country_id
                                               FROM country
                                               WHERE country = 'Canada')),
        0, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                         INNER JOIN film AS F ON I.film_id = F.film_id
                         WHERE F.title = 'STARSHIP TROOPERS'
                         LIMIT 1), 2, CURRENT_DATE(), (SELECT MAX(staff_id)
                                                       FROM staff
                                                       WHERE store_id = 1));

UPDATE film
SET release_year = CASE rating
                       WHEN 'G' THEN '2000'
                       WHEN 'PG' THEN '2003'
                       ELSE release_year
                   END;

SELECT F.film_id
FROM film AS F
INNER JOIN inventory AS I ON I.film_id = F.film_id
INNER JOIN rental AS R ON I.inventory_id = R.inventory_id
WHERE R.return_date > CURRENT_DATE()
ORDER BY rental_date DESC
LIMIT 1;

DELETE FROM film
WHERE film_id = 2;

START TRANSACTION;

DELETE FROM film_actor
WHERE film_id = 2;

DELETE FROM film_category
WHERE film_id = 2;

DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 2);

DELETE FROM inventory
WHERE film_id = 2;

DELETE FROM film
WHERE film_id = 2;

ROLLBACK;

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                         WHERE NOT EXISTS(SELECT *
                                          FROM rental AS R
                                          WHERE R.inventory_id = I.inventory_id
                                            AND R.return_date < CURRENT_DATE())
                         LIMIT 1), 2, CURRENT_DATE(), 2);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (2, 2, LAST_INSERT_ID(), 9.5, CURRENT_DATE());

