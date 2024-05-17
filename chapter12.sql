
-- How to create views
-- Objectives

-- Applied
-- Create and use views, including read-only and
-- updatable views.

-- Describe a view.
-- Describe the benefits of using views.
-- Given a view, determine whether it is updatable.
-- Describe the effect of the WITH CHECK OPTION clause on an updatable view.


DROP DATABASE ap;

-- A CREATE VIEW statement
CREATE VIEW vendors_min AS
	SELECT vendor_name, vendor_state, vendor_phone
		FROM vendors;
        
-- A SELECT statement that uses the view       
SELECT * FROM vendors_min
    WHERE vendor_state = 'CA'
		ORDER BY vendor_name;
        
-- An UPDATE statement that uses the view
-- to update the base table        
        
UPDATE vendors_min
	SET vendor_phone = '(800) 555-3941'
		WHERE vendor_name = 'Rigisters Of Copyrights';
        
-- A statement that drops the view        
DROP VIEW vendors_min;

-- Some of the benefits provided by views        

-- Design independence
-- Data security
-- Simplified queries
-- Updatability
                
-- The syntax of the CREATE VIEW statement

-- CREATE [OR REPLACE] VIEW view_name 
--   [(column_alias_1[, column_alias_2]...)]
-- AS
--   select_statement
--   [WITH CHECK OPTION]
        
-- A view of vendors that have invoices
CREATE VIEW vendors_phone_list AS
	SELECT vendor_name, vendor_contact_last_name,
		vendor_contact_first_name, vendor_phone
			FROM vendors
				WHERE vendor_id IN (
					SELECT DISTINCT vendor_id FROM invoices);
                    
-- A view that uses a join                    
CREATE OR REPLACE VIEW vendor_invoices AS
	SELECT vendor_name, invoice_number, invoice_date,
		invoice_total FROM vendors
			JOIN invoices
				ON vendors.vendor_id = invoices.vendor_id;
                
-- A view that uses a LIMIT clause
CREATE OR REPLACE VIEW top5_invoice_totals
	AS SELECT vendor_id, invoice_total
		FROM invoices
			ORDER BY invoice_total DESC
				LIMIT 5;
                
-- A view that names all of its columns 
-- in the CREATE VIEW clause
CREATE OR REPLACE VIEW invoices_outstandsing
	(invoice_number, invoice_date, invoice_total, balance_due)
		AS SELECT invoice_number, invoice_date, invoice_total,
			invoice_total - payment_total - credit_total
				FROM invoices
					WHERE invoice_total - payment_total - credit_total > 0;
			
-- A view that names just the calculated column
-- in its SELECT clause		
CREATE OR REPLACE VIEW invoices_outstanding AS
    SELECT invoice_number, invoice_date, invoice_total,
		invoice_date - payment_total - credit_total
			AS balance_due
				FROM invoices
					WHERE invoice_total -payment_total - credit_total > 0;
		
-- A view that summarizes invoices by vendor        
CREATE OR REPLACE VIEW invoices_summary AS
	SELECT vendor_name, COUNT(*) AS invoice_count,
		SUM(invoice_total) AS invoice_total_sum
			FROM vendors
				JOIN invoices
					ON vendors.vendor_id = invoices.vendor_id
						GROUP BY vendor_name;
                        
-- Updateable Views

-- Requirements for creating updatable views                        
-- The select list can’t include a DISTINCT clause.
-- The select list can’t include aggregate functions.
-- The SELECT statement can’t include a GROUP BY or HAVING clause.
-- The view can’t include the UNION operator.
                        
-- A CREATE VIEW statement that
-- creates an updatable view

DROP VIEW  balance_due_view;

CREATE OR REPLACE VIEW balance_due_view AS
	SELECT vendor_name, invoice_number,
		invoice_total, payment_total, credit_total,
			invoice_total - payment_total - credit_total
				AS balance_due
					FROM vendors JOIN invoices
						ON vendors.vendor_id = invoices.vendor_id
							WHERE invoice_total - payment_total - credit_total > 0;
                            
-- An UPDATE statement that uses the view
UPDATE balance_due_view
	SET credit_total = 300
		WHERE invoice_number = '9982771';
                            
-- The response from the system

-- An UPDATE statement that attempts to use
-- the view to update a calculated column
UPDATE balance_due_view
	SET balance_due = 0
		WHERE invoice_number = '9982771';
        
-- The response from the system
-- Error Code: 1348. Column 'balance_due' is not updatable

-- An updatable view that has
-- a WITH CHECK OPTION clause
CREATE OR REPLACE VIEW vendor_payment AS
    SELECT vendor_name, invoice_number, invoice_date
		payment_date, invoice_total, credit_total
			payment_total
				FROM vendors JOIN invoices
					ON vendors.vendor_id = invoices.vendor_id
						WHERE invoice_total - payment_total - credit_total
							>= 0 WITH CHECK OPTION;
                            
-- If you use WITH CHECK OPTION…
-- An error will occur if you try to modify a row so it’s no
-- longer included in the view.

SELECT * FROM vendor_payment
	WHERE invoice_number = 'P-0608';
                            
-- An UPDATE statement that updates the view                            
UPDATE vendor_payment
    SET payment_total = 400.00,
		payment_date = '2018-08-01'
			WHERE invoice_number = 'P-0608';
            
-- A statement that creates an updatable view            
CREATE OR REPLACE VIEW ibm_invoices
    AS SELECT invoice_number, invoice_date, invoice_total
		FROM invoices
			WHERE vendor_id = 34;
            
-- An INSERT statement that fails due to columns
-- that don’t have values            
INSERT INTO ibm_invoices (invoice_number, invoice_date, invoice_total)
    VALUES ('RA23988', '2018-07-31', 417.34);				
            
-- The response from the system

-- Error Code: 1423. Field of view 'ap.ibm_invoices'
-- underlying table doesn't have a default value
            
-- A DELETE statement that fails
-- due to a foreign key constraint
DELETE FROM ibm_invoices
    WHERE invoice_number = 'Q545443';
    
-- The response from the system

-- Error Code: 1451. Cannot delete or update a
-- parent row: a foreign key constraint fails ('ap'.'invoice_line_items',
-- CONSTRAINT 'line_items_fk_invoices' FOREIGN KEY
-- ('invoice_id') REFERENCES 'invoices' ('invoice_id'))
    
-- Two DELETE statements that succeed    
DELETE FROM invoice_line_items
    WHERE invoice_id = (SELECT invoice_id
		FROM invoices
			WHERE invoice_number = 'Q545443');				
            
DELETE FROM ibm_invoices
    WHERE invoice_number = 'Q545443';
    
-- A statement that creates a view    
CREATE VIEW vendors_sw AS
    SELECT * FROM vendors
		WHERE vendor_state IN ('CA', 'AZ', 'NV', 'NM');
        
-- A statement that replaces the view
-- with a new view
CREATE OR REPLACE VIEW vendors_sw AS
    SELECT * FROM vendors
		WHERE vendor_state IN ('CA', 'AZ', 'NV', 'NM', 'UT', 'CO');
        
-- A statement that drops the view
DROP VIEW vendors_sw;        
            
			
            
            
            
            
            


			
	







                        
                        
                        
    			
        
        
        
        
        
        
																																																								






                
                
				





                
                
                
		
    						
                    
                    
                    
                    
                    
                    
        
        









