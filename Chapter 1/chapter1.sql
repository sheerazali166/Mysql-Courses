
-- A SELECT statement that retrieves and sorts selected
--  columns and rows

USE ap;

SELECT invoice_number, invoice_date, invoice_total,
	payment_total, credit_total
		AS balance_due
			FROM invoices
				WHERE invoice_total - payment_total - credit_total
					> 0
						ORDER BY invoice_date;
                        

-- A SELECT statement that joins data 

SELECT vendor_name, invoice_number, invoice_date,
	invoice_total
		FROM ap.vendors INNER JOIN ap.invoices
			ON ap.vendors.vendor_id = ap.invoices.vendor_id
				WHERE invoice_total >= 500
					ORDER BY vendor_name, invoice_total DESC;


-- A statement that adds a row to the Invoices table

INSERT INTO invoices
	(vendor_id, invoice_number,
		invoice_date, invoice_total,
			terms_id, invoice_due_date)
				VALUES (12, '3289175', '2018-07-18',
					165, 3, '2018-08-17');
                    
SELECT * FROM invoices WHERE vendor_id = 12;

-- A statement that changes the value of a column for one row

SELECT * FROM invoices WHERE invoice_number = '367447';

UPDATE invoices SET credit_total = 35.89
	WHERE invoice_number = '367447';
    
SELECT * FROM invoices WHERE invoice_number = '367447';    
    
-- A statement that changes the value of a column for multiple rows

SELECT * FROM invoices WHERE terms_id = 4;  

UPDATE invoices
	SET invoice_due_date = DATE_ADD(invoice_due_date, INTERVAL 30 DAY)
		WHERE terms_id = 4;
        
SELECT * FROM invoices WHERE terms_id = 4;


-- A statement that deletes a selected invoice rom the Invoices table 

SELECT * FROM invoices WHERE invoice_number = '4-342-8069';

DELETE FROM invoices
	WHERE invoice_number = '4-342-8069';
    
-- A statement that deletes all paid invoices from the Invoices table


DELETE FROM invoices
	WHERE invoice_total - payment_total -
		credit_total = 0;
        
-- A SELECT statement that’s difficult to read        

SELECT invoice_number, invoice_date, invoice_total,
	payment_total, credit_total, invoice_total
		- payment_total - credit_total as balance_due
			FROM invoices
				WHERE invoice_total - payment_total - credit_total
					> 0 ORDER BY invoice_date;
                    
-- A SELECT statement that’s easy to read

SELECT invoice_number, invoice_date, invoice_total
	payment_total, credit_total
		AS balance_due
			FROM invoices
				WHERE invoice_total - payment_total - credit_total
					> 0 ORDER BY invoice_date;
                    
-- A SELECT statement with a block comment

/*
	Author: Aspen Olmsted
    Date: 8/22/2018
*/               
 
SELECT invoice_number, invoice_date, invoice_total,
	invoice_total - payment_total - credit_total
		AS balance_due
			FROM invoices;
            
-- A SELECT statement with a single-line comment

-- The fourth column calculates the balance due

SELECT invoice_number, invoice_date, invoice_total,
	invoice_total - payment_total - credit_total
		AS balance_daue
			FROM invoices;
            
			
				
    
		

                    
                    
                    
                    
			
                        

