--2. Add a new column in the customer table for Platinum Member. This can be a boolean.
--Platinum Members are any customers who have spent over $200. 
--Create a procedure that updates the Platinum Member column to True for 
--any customer who has spent over $200 and False for any customer who has spent less than $200.
--Use the payment and customer table.



SELECT *
FROM customer  

ALTER TABLE customer 
ADD  platinum_member BOOLEAN DEFAULT False;

ALTER TABLE customer 
DROP COLUMN platinum_member;

CREATE OR REPLACE PROCEDURE platinum_check()
LANGUAGE plpgsql
AS $$
BEGIN
		UPDATE customer
		SET platinum_member = TRUE
		WHERE customer_id IN (
			SELECT customer_id 
			FROM payment
			GROUP BY payment.customer_id 
			HAVING SUM(payment.amount) > 200
);
		COMMIT;
END;
$$



