
-- Converting Data Types

-- Implicitly convert a number to a string
SELECT invoice_total, CONCAT('$', invoice_total)
	FROM invoices;
    
-- Implicitly convert a string to a number
SELECT invoice_number, 989319/invoice_number
		FROM invoices;
        
-- Implicitly convert a date to a number        
SELECT invoice_date, invoice_date + 1
    FROM invoices;			

-- A statement that uses the CAST function
SELECT invoice_id, invoice_date, invoice_total,
    CAST(invoice_date AS CHAR(10)) AS char_date,
		CAST(invoice_total AS SIGNED) AS integer_total
			FROM invoices;

-- A statement that uses the CONVERT function
 SELECT invoice_id, invoice_date, invoice_total,
	CONVERT(invoice_date, CHAR(10)) AS char_date,
		CONVERT(invoice_total, SIGNED) AS integer_total
			FROM invoices;
 
-- CHAR function examples
-- for common control characters

-- Function	Control character
-- CHAR(9)	Tab
-- CHAR(10)	Line feed
-- CHAR(13)	Carriage return

-- A statement that uses the CHAR function 
SELECT CONCAT(vendor_name, CHAR(13, 10),
	vendor_address1, CHAR(13, 10), vendor_city,
		', ', vendor_state, ' ', vendor_zip_code)
			FROM vendors WHERE vendor_id = 1;



 
 
        
        
        
        
        
        