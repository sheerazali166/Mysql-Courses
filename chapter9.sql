
-- How to use functions

-- Objectives

-- Applied

-- Code queries that format numeric or
-- date/time data.

-- Code queries that require any of the
-- scalar functions presented in this
-- chapter.

-- Code queries that require any of the
-- ranking or analytic functions
-- presented in this chapter.

-- Knowledge

-- Describe how the use of functions
-- can solve the problems associated
-- with (1) sorting string data that
-- contains numeric values, and (2)
-- doing date or time searches.
-- Describe the use of the ranking
-- functions for ranking the rows
-- returned by a result set.

-- Describe the use of the analytic
-- functions for performing calculations
-- on ordered sets of data.

-- Some of the string functions

-- CONCAT(str1[,str2]...)
-- CONCAT_WS(sep,str1[,str2]...)
-- LTRIM(str) 
-- RTRIM(str)
-- TRIM([[BOTH|LEADING|TRAILING] [remove] FROM] str)
-- LENGTH(str)
-- LOCATE(find,search[,start])
-- LEFT(str,length) 
-- RIGHT(str,length)
-- SUBSTRING_INDEX(str,delimiter, count)
-- SUBSTRING(str,start[,length])

-- Some of the string functions (continued)

-- CONCAT(str1[,str2]...)
-- CONCAT_WS(sep,str1[,str2]...)
-- LTRIM(str) 
-- RTRIM(str)
-- TRIM([[BOTH|LEADING|TRAILING] [remove] FROM] str)
-- LENGTH(str)
-- LOCATE(find,search[,start])
-- LEFT(str,length) 
-- RIGHT(str,length)
-- SUBSTRING_INDEX(str,delimiter, count)
-- SUBSTRING(str,start[,length])

-- Some of the string functions (continued)

-- REPLACE(search,find,replace)
-- INSERT(str,start,length,insert)
-- REVERSE(str)
-- LOWER(str) 
-- UPPER(str)
-- LPAD(str,length,pad)
-- RPAD(str,length,pad)
-- SPACE(count)
-- REPEAT(str,count) 

-- String function examples

-- Function                                    Result
-- CONCAT('Last', 'First')					   'LastFirst'
-- CONCAT_WS(', ', 'Last', 'First')			   'Last, First'
--  
-- LTRIM('  MySQL  ')	               			'MySQL  '
-- RTRIM('  MySQL  ')	               			'  MySQL'
-- TRIM('  MySQL  ')	               			'MySQL'
-- TRIM(BOTH '*' FROM '****MySQL****')			'MySQL'
--  
-- LOWER('MySQL')	               				'mysql' 
-- UPPER('ca')	                       			'CA'   
--  
-- LEFT('MySQL', 3)	               			    'MyS'
-- RIGHT('MySQL', 3)	               			'SQL'

-- String function examples (continued)

-- Function												Result
-- SUBSTRING('(559) 555-1212', 7, 8)	          		'555-1212'
-- SUBSTRING_INDEX('http://www.murach.com', '.', -2) 	'murach.com' 
--  
-- LENGTH('MySQL')	                            			5
-- LENGTH('  MySQL  ')                               		9
--  
-- LOCATE('SQL', '  MySQL')                          		5
-- LOCATE('-', '(559) 555-1212')	                   		10
--  
-- REPLACE(RIGHT('(559) 555-1212', 13),') ', '-')		'559-555-1212'
-- INSERT("MySQL", 1, 0, "Murach's ")	         		"Murach's MySQL"
-- INSERT('MySQL', 1, 0, 'Murach''s ')	         		"Murach's MySQL"

-- A SELECT statement that uses three functions

SELECT vendor_name, CONCAT_WS(', ',
	vendor_contact_last_name, vendor_contact_first_name)
		AS contact_name, RIGHT(vendor_phone, 8) AS phone
			FROM vendors WHERE LEFT(vendor_phone, 4) = '(559'
				ORDER BY contact_name;

-- How to sort by a string column
-- that contains numbers (part 1)

Use ex;

-- Sorted by the emp_id column
SELECT * FROM string_sample
	ORDER BY emp_id;

-- How to sort by a string column
-- that contains numbers (part 2)

-- Sorted by the emp_id column explicitly cast as an integer
SELECT * FROM string_sample
	ORDER BY CAST(emp_id AS SIGNED);
    
-- How to sort by a string column
-- that contains numbers (part 3)

-- Sorted by the emp_id column implicitly cast as an integer
SELECT * FROM string_sample
	ORDER BY emp_id + 0;
    
-- How to sort by a string column
-- that contains numbers (part 4)

-- Sorted by the emp_id column after it has been padded
-- with leading zeros

SELECT LPAD(emp_id, 2, '0') AS emp_id, emp_name
	FROM string_sample
		ORDER BY emp_id ;
        
-- How to use the SUBSTRING_INDEX function
-- to parse a string
SELECT emp_name, SUBSTRING_INDEX(emp_name, ' ', 1) AS first_name,
	SUBSTRING_INDEX(emp_name, ' ', -1) AS last_name
		FROM string_sample;
	
-- How to use the LOCATE function
-- to find a character in a string

SELECT emp_name, LOCATE(' ', emp_name) AS first_space,
	LOCATE(' ', emp_name, LOCATE(' ', emp_name) + 1)
		AS second_space
			FROM string_sample;
            
-- How to use the SUBSTRING function
-- to parse a string

SELECT emp_name, SUBSTRING(emp_name, 1, LOCATE(' ', emp_name) -1)
	AS first_name, SUBSTRING(emp_name, LOCATE(' ', emp_name) + 1)
		AS last_name
			FROM string_sample;

-- Some of the numeric functions

-- ROUND(number[,length])
-- TRUNCATE(number,length)
-- CEILING(number)
-- FLOOR(number)
-- ABS(number)
-- SIGN(number)
-- SQRT(number)
-- POWER(number,power)
-- RAND([integer])

-- Examples that use the
-- numeric functions

-- Function	              Result
-- ROUND(12.49,0)			12
-- ROUND(12.50,0)			13
-- ROUND(12.49,1)			12.5
-- TRUNCATE(12.51,0)		12
-- TRUNCATE(12.49,1)		12.4

-- Examples that use the numeric functions (continued)

-- Function	         Result
-- CEILING(12.5)	   13
-- CEILING(-12.5)	  -12
-- FLOOR(-12.5)	      -13
-- FLOOR(12.5)	       12
-- ABS(-1.25)	       1.25
-- ABS(1.25)	       1.25
-- SIGN(-1.25)	      -1
-- SIGN(1.25)	       1

-- SQRT(125.43)	       11.199553562530964
-- POWER(9,2)	       81
--  
-- RAND()	           0.2444132019248

-- The Float_Sample table
SELECT * FROM float_sample;

-- A search for an exact value
-- that doesn’t include two approximate values

SELECT * FROM float_sample
	WHERE float_value = 1;

-- How to search for approximate values

-- Search for a range of values

SELECT * FROM float_sample
	WHERE float_value BETWEEN 0.99 AND 1.01;
    
-- Search for rounded values    
SELECT * FROM float_sample
    WHERE ROUND(float_value, 2) = 1.00;
   
-- Functions that get the current date and time   

-- NOW()
-- SYSDATE()
-- CURRENT_TIMESTAMP()
--  
-- CURDATE()
-- CURRENT_DATE()
--  
-- CURTIME()
-- CURRENT_TIME()
--  
-- UTC_DATE()
--  
-- UTC_TIME()

-- Examples that get the current date and time
   
-- Function	              Result
-- NOW()               2018-12-06 14:12:04
-- SYSDATE()	        2018-12-06 14:12:04
-- CURDATE()	        2018-12-06
-- CURTIME()	        14:12:04
--  
-- UTC_DATE()	        2018-12-06
-- UTC_TIME()	        21:12:04
--  
-- CURRENT_TIMESTAMP()	2018-12-06 14:12:04
-- CURRENT_DATE()      2018-12-06
-- CURRENT_TIME()      14:12:04

-- Some of the date/time parsing functions

-- DAYOFMONTH(date)
-- MONTH(date)
-- YEAR(date)
-- HOUR(time)
-- MINUTE(time)
-- SECOND(time)
-- DAYOFWEEK(date)
--  
-- QUARTER(date) 
-- DAYOFYEAR(date)
-- WEEK(date[,first])
--  
-- LAST_DAY(date)
--  
-- DAYNAME(date)
-- MONTHNAME(date)

-- Examples that use the date/time parsing functions
   
-- Function					Result
-- DAYOFMONTH('2018-12-03')	  3
-- MONTH('2018-12-03')	      12
-- YEAR('2018-12-03')	      2018
-- HOUR('11:35:00')	          11
-- MINUTE('11:35:00')	      35
-- SECOND('11:35:00')	      0
-- DAYOFWEEK('2018-12-03')    2
-- QUARTER('2018-12-03')	  4
-- DAYOFYEAR('2018-12-03')	  337
-- WEEK('2018-12-03')	      48
-- LAST_DAY('2018-12-03')	  31
--  
-- DAYNAME('2018-12-03')	  Monday
-- MONTHNAME('2018-12-03')	  December

-- The EXTRACT function
-- EXTRACT(unit FROM date)

-- Date/time units
-- Unit	          Description
-- SECOND		    Seconds
-- MINUTE			Minutes
-- HOUR	            Hours
-- DAY	            Day
-- MONTH	        Month
-- YEAR	          	Year
-- MINUTE_SECOND	Minutes and seconds
-- HOUR_MINUTE	    Hour and minutes
-- DAY_HOUR		    Day and hours
-- YEAR_MONTH		Year and month
-- HOUR_SECOND		Hours, minutes, and seconds
-- DAY_MINUTE		Day, hours, and minutes
-- DAY_SECOND		Day, hours, minutes, and seconds

-- Examples that use the EXTRACT function

-- Function                                            Result
-- EXTRACT(SECOND FROM '2018-12-03 11:35:00')          0
-- EXTRACT(MINUTE FROM '2018-12-03 11:35:00')          35
-- EXTRACT(HOUR FROM '2018-12-03 11:35:00')            11
-- EXTRACT(DAY FROM '2018-12-03 11:35:00')             3
-- EXTRACT(MONTH FROM '2018-12-03 11:35:00')           12
-- EXTRACT(YEAR FROM '2018-12-03 11:35:00')            2018
-- EXTRACT(MINUTE_SECOND FROM '2018-12-03 11:35:00')   3500
-- EXTRACT(HOUR_MINUTE FROM '2018-12-03 11:35:00')     1135
-- EXTRACT(DAY_HOUR FROM '2018-12-03 11:35:00')        311
-- EXTRACT(YEAR_MONTH FROM '2018-12-03 11:35:00')      201812
-- EXTRACT(HOUR_SECOND FROM '2018-12-03 11:35:00')     113500
-- EXTRACT(DAY_MINUTE FROM '2018-12-03 11:35:00')      31135
-- EXTRACT(DAY_SECOND FROM '2018-12-03 11:35:00’)	   3113500

-- Two functions for formatting dates and times

-- DATE_FORMAT(date,format)
-- TIME_FORMAT(time,format)

-- Common codes for date/time format strings

-- Code	     Description
-- %m        Month, numeric (01…12)
-- %c	     Month, numeric (1…12)
-- %M        Month name (January…December)
-- %b	     Abbreviated month name (Jan…Dec)
-- %d	     Day of the month, numeric (00…31)
-- %e	     Day of the month, numeric (0…31)
-- %D	     Day of the month with suffix (1st, 2nd, 3rd, etc.)
-- %y	     Year, numeric, 2 digits
-- %Y	     Year, numeric, 4 digits

-- Common codes for date/time format strings (continued)

-- Code	Description
-- %W        Weekday name (Sunday…Saturday)
-- %a	      Abbreviated weekday name (Sun…Sat)
-- %H	      Hour (00…23)
-- %k	      Hour (0…23)
-- %h	      Hour (01…12)
-- %l	      Hour (1…12)
-- %i	      Minutes (00…59)
-- %r	      Time, 12-hour (hh:mm:ss AM or PM)
-- %T	      Time, 24-hour (hh:mm:ss)
-- %S	      Seconds (00…59)
-- %p        AM or PM

-- Examples that use the date/time formatting functions

-- Function	                       		    	Result
-- DATE_FORMAT('2018-12-03',’%m/%d/%y')			12/03/18
-- DATE_FORMAT('2018-129-03','%W, %M %D, %Y')	Monday, December 3rd, 2018
-- DATE_FORMAT('2018-12-03', '%e-%b-%y')		3-Dec-18
-- DATE_FORMAT('2018-12-03 16:45', '%r')		04:45:00 PM
-- TIME_FORMAT('16:45', '%r')	                04:45:00 PM
-- TIME_FORMAT('16:45', '%l:%i %p')	        	4:45 PM

-- Some of the functions for calculating dates and times

-- DATE_ADD(date,INTERVAL expression unit)
-- DATE_SUB(date,INTERVAL expression unit)
-- DATEDIFF(date1, date2)
-- TO_DAYS(date)
-- TIME_TO_SEC(time

-- Examples of the functions for calculating dates and times

-- Function												 	 Result
-- DATE_ADD('2018-12-31', INTERVAL 1 DAY)	                 2019-01-01
-- DATE_ADD('2018-12-31', INTERVAL 3 MONTH)	                 2019-03-31
-- DATE_ADD('2018-12-31 23:59:59', INTERVAL 1 SECOND)	     2019-01-01 00:00:00
-- DATE_ADD('2019-01-01', INTERVAL -1 DAY)	                 2018-12-31
-- DATE_SUB('2019-01-01', INTERVAL 1 DAY)	                 2018-12-31
-- DATE_ADD('2016-02-29', INTERVAL 1 YEAR)	                 2017-02-28
-- DATE_ADD('2018-02-29', INTERVAL 1 YEAR)	                 NULL
-- DATE_ADD('2018-12-31 12:00', INTERVAL '2 12' DAY_HOUR)	 2019-01-03 00:00:00

-- Examples of the functions for calculating dates and times (continued)
-- Function											Result
-- DATEDIFF('2018-12-30', '2018-12-03')				27
-- DATEDIFF('2018-12-30 23:59:59', '2018-12-03')	27
-- DATEDIFF('2018-12-03', '2018-12-30')			   -27
--  
-- TO_DAYS('2018-12-30') - TO_DAYS('2018-12-03')	27
-- TIME_TO_SEC('10:00') - TIME_TO_SEC('09:59')		60

-- The contents of the Date_Sample table with times
SELECT * FROM date_sample;

-- A SELECT statement that fails to return a row
SELECT * FROM date_sample
	WHERE start_date = '2018-02-28';
    
-- Three techniques for ignoring time values    
-- Search for a range of dates
SELECT * FROM date_sample
    WHERE start_date >= '2018-02-28'
		AND start_date < '2018-03-01';
        
-- Search for month, day, and year integers
SELECT * FROM date_sample
    WHERE MONTH(start_date) = 2 AND
		DAYOFMONTH(start_date) = 28 AND
			YEAR(start_date) = 2018;
		
SELECT 2018 + 28;        

-- Three techniques for ignoring time values (continued)
-- Search for a formatted date
SELECT * FROM date_sample
	WHERE DATE_FORMAT(start_date, '%m-%d-%Y')
		= '02-28-2018';

-- The contents of the Date_Sample table with dates    
SELECT * FROM date_sample;

-- A SELECT statement that fails to return a row
SELECT * FROM date_sample
	WHERE TIME_FORMAT(start_date, 'hh:mm:ss') = '10:00:00';
    
SELECT * FROM date_sample
	WHERE TIME_FORMAT(start_date, '%r') = '10:00:00';    

USE ex;

-- Examples that ignore date values
-- Search for a time that has been formatted
SELECT * FROM date_sample
	WHERE DATE_FORMAT(start_date, '%T') = '10:00:00';
    
-- Search for a time that hasn’t been formatted
SELECT * FROM date_sample
    WHERE EXTRACT(HOUR_SECOND FROM start_date) = 100000;		
    
-- Examples that ignore date values (continued)
-- Search for an hour of the day
SELECT * FROM date_sample
	WHERE HOUR(start_date) = 9;
    
-- Search for a range of times
SELECT * FROM date_sample
    WHERE EXTRACT(HOUR_MINUTE FROM start_date)
		BETWEEN 900 AND 1200;
        
-- Decision Branching Functions        
 
 -- The syntax of the simple CASE function
--  CASE input_expression
--     WHEN when_expression_1 THEN result_expression_1
--    [WHEN when_expression_2 THEN result_expression_2]...
--    [ELSE else_result_expression]
-- END

USE ap;

-- A statement that uses a simple CASE function

SELECT invoice_number, terms_id,
	CASE terms_id
		WHEN 1 THEN 'Net due 10 days'
        WHEN 2 THEN 'Net due 20 days'
        WHEN 3 THEN 'Net due 30 days'
        WHEN 4 THEN 'Net due 60 days'
        WHEN 5 THEN 'Net due 90 days'
	END AS terms
FROM invoices;

-- The syntax of the searched CASE function

-- CASE
--     WHEN conditional_expression_1
--         THEN result_expression_1
--    [WHEN conditional_expression_2
--         THEN result_expression_2]...
--    [ELSE else_result_expression]
-- END

-- A statement that uses a searched CASE function    
SELECT invoice_number, invoice_total, invoice_date,
	invoice_due_date,
		CASE
			WHEN DATEDIFF(NOW(), invoice_due_date) > 30
			    THEN 'Over 30 days past due'
            WHEN DATEDIFF(NOW(), invoice_due_date) > 0
				THEN '1 to 30 days past due'
            ELSE 'Current'
        END AS invoice_status
    FROM invoices
WHERE invoice_total - payment_total - credit_total > 0;

-- The syntax of the IF function    
-- IF(test_expression, if_true_expression, else_expression)

-- A SELECT statement that uses the IF function
SELECT vendor_name,
	IF (vendor_city = 'Fresno', 'Yes', 'No')
		AS is_city_fresno
			FROM vendors;

-- The syntax of the IFNULL function
-- IFNULL(test_expression, replacement_value)

-- A SELECT statement that uses the IFNULL function
SELECT payment_date,
	IFNULL (payment_date, 'No Payment') AS new_date
		FROM invoices;

-- The syntax of the COALESCE function
-- COALESCE(expression_1[, expression_2]...)

-- A SELECT statement that uses the COALESCE function
SELECT payment_date,
	COALESCE (payment_date, 'No Payment') AS new_date
		FROM invoices;
        
 -- Regular Expression Functions       

-- The syntax of the regular expression functions        
-- REGEXP_LIKE(expr, pattern)
-- REGEXP_INSTR(expr, pattern [, start])
-- REGEXP_SUBSTR(expr, pattern [, start])
-- REGEXP_REPLACE(expr, pattern, replace[, start])

-- Regular expression special characters and constructs
-- Character/Construct       Description
-- ^	          			 Matches the pattern to the beginning of the value.
-- $	           		     Matches the pattern to the end of the value.
-- .	           			 Matches any single character.
-- [charlist]           	 Matches any single character listed within the brackets.
-- [char1–char2]     		 Matches any single character within the given range.
-- |	            		 Separates two string patterns and matches either one.
-- char*	            	 Matches zero or more occurrences of the character.
-- (charlist)*          	 Matches zero or more occurrences of the sequence of
-- 						     characters in parentheses.

-- Examples of the regular expression functions
 
-- Example	                             	Result
-- REGEXP_LIKE('abc123', '123')	           	   1
-- REGEXP_LIKE('abc123', '^123')	       	   0
-- REGEXP_INSTR('abc123', '123')	           4
-- REGEXP_SUBSTR('abc123', '[A-Z][1-9]*$')     c123
-- REGEXP_REPLACE('abc123', '1|2', '3')	       abc333 
   
-- A statement that uses the REGEXP_INSTR function   
SELECT DISTINCT vendor_city,
	REGEXP_INSTR(vendor_city, ' ') AS space_index
		FROM vendors
			WHERE REGEXP_INSTR (vendor_city, ' ') > 0
				ORDER BY vendor_city;
                
 -- A statement that uses the REGEXP_SUBSTR function               
SELECT vendor_city,
	REGEXP_SUBSTR(vendor_city, '^SAN|LOS') AS city_match
		FROM vendors
			WHERE REGEXP_SUBSTR(vendor_city, '^SAN|LOS') IS NOT NULL;
            
-- A statement that uses the REGEXP_REPLACE and REGEXP_LIKE functions            
SELECT vendor_name, vendor_address1,
    REGEXP_REPLACE (vendor_address1, 'STREET', 'St')
		AS new_address1
			FROM vendors
				WHERE REGEXP_LIKE (vendor_address1, 'STREET');
                
-- Window Functions                

-- The syntax of the four ranking functions                
-- ROW_NUMBER()              OVER([partition_clause] order_clause)
-- RANK()                    OVER([partition_clause] order_clause)
-- DENSE_RANK()              OVER([partition_clause] order_clause)
-- NTILE(integer_expression) OVER([partition_clause] order_clause)
                
-- A query that uses the ROW_NUMBER function                
SELECT ROW_NUMBER() OVER(ORDER BY vendor_name)
    AS 'row_number', vendor_name
		FROM vendors;
        
-- A query that uses the PARTITION BY clause
SELECT ROW_NUMBER() OVER(PARTITION BY vendor_state
	ORDER BY vendor_name) AS 'row_number', vendor_name,
		vendor_state
			FROM vendors;

-- A query that uses the RANK and DENSE_RANK functions
SELECT RANK() OVER(ORDER BY invoice_total) AS 'rank',
	DENSE_RANK() OVER(ORDER BY invoice_total) AS 'dense rank',
		invoice_total, invoice_number FROM invoices;

-- A query that uses the NTILE function		
SELECT terms_description,
	NTILE(2) OVER (ORDER BY terms_id) AS title2,
    NTILE(3) OVER (ORDER BY terms_id) AS title3,
	NTILE(4) OVER (ORDER BY terms_id) AS title4
FROM terms;

-- The syntax of the analytic functions
-- {FIRST_VALUE|LAST_VALUE|NTH_VALUE}
--     (scalar_expression[, numeric_literal])
--     OVER ([partition_clause] order_clause [frame_clause])
-- {LEAD|LAG}(scalar_expression [, offset [, default]])
--     OVER ([partition_clause] order_clause)
-- {PERCENT_RANK()|CUME_DIST()}

-- The columns in the Sales_Reps table
-- Column name	    Data type
-- rep_id		    INT
-- rep_first_name	VARCHAR(50)
-- rep_last_name	VARCHAR(50)

-- The columns in the Sales_Totals table
-- Column name	    Data type
-- rep_id		    INT
-- sales_year		YEAR
-- sales_total		DECIMAL(9,2)

USE ex;

-- A query that uses the FIRST_VALUE, NTH_VALUE, and LAST_VALUE functions
SELECT sales_year, CONCAT(rep_first_name, ' ', rep_last_name)
	AS rep_name, sales_total,
		FIRST_VALUE(CONCAT(rep_first_name, ' ', rep_last_name))
			OVER(PARTITION BY sales_year ORDER BY sales_total DESC)
				AS highest_sales,
					NTH_VALUE(CONCAT(rep_first_name, ' ', rep_last_name), 2)
						OVER (PARTITION BY sales_year ORDER BY sales_total DESC
							RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
								AS second_highest_sales,
									LAST_VALUE(CONCAT(rep_first_name, ' ', rep_last_name))
										OVER (PARTITION BY sales_year ORDER BY sales_total DESC
											RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
												AS lowest_sales
													FROM sales_totals JOIN sales_reps
														ON sales_totals.rep_id = sales_reps.rep_id;
		
-- A query that uses the LAG function
SELECT rep_id, sales_year, sales_total as current_sales,
	LAG(sales_total, 1, 0)
	    OVER(PARTITION BY rep_id ORDER BY sales_year)
			AS last_sales,
				sales_total - LAG(sales_total, 1, 0)
					OVER(PARTITION BY rep_id ORDER BY sales_year)
						AS 'change'
							FROM sales_totals;
                            
-- A query that uses the PERCENT_RANK and CUME_DIST functions                            
SELECT sales_year, rep_id, sales_total,
    PERCENT_RANK()
		OVER(PARTITION BY sales_year ORDER BY sales_total)
			AS pct_rank,
				CUME_DIST()
					OVER(PARTITION BY sales_year ORDER BY sales_total)
						AS 'cume_dist'
							FROM sales_totals;
				
                            
                            
		










	
    
        
        
        
        
        
        
                
                
                

                
                
   
    
    






   
   
   
   
   
   
    
    
    
    
    
    
    
    
    
    
































            
            
		









        
	



    
    
    
    








    
    
    








