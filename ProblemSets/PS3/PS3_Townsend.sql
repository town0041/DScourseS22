-- ******************
-- Import data
-- ******************
-- Season,Daynum,Wteam,Wscore,Lteam,Lscore,Wloc,Numot
-- 1985,20,1228,81,1328,64,N,0
.print ' '
.print 'Importing data'
-- First, create the table that the CSV will be stored in
CREATE TABLE "FloridaInsurance" (
	PolicyID INTEGER,
	StateCode  CHAR(10),
	County CHAR(100),
	eq_site_limit  DOUBLE,
	hu_site_limit DOUBLE,
	fl_site_limit DOUBLE,
	fr_site_limit DOUBLE,
	tiv_2011 DOUBLE,
	tiv_2012 DOUBLE,
	eq_site_deductible DOUBLE,
	hu_site_deductible DOUBLE,
	fl_site_deductible DOUBLE,
	fr_site_deductible DOUBLE, 
	Point_latitude DOUBLE, 
	point_longitude DOUBLE,
	line CHAR(100)
	construction CHAR(100),
	point_granularity INTEGER
	
);

-- Tell SQL to expect a CSV file by declaring CSV mode
.mode csv

-- Next, import the CSV following the directions on the sqlitetutorial website
.import FL_insurance_sample.csv FloridaInsurance





-- ******************
-- View first 10 observations
-- ******************
.print ' '
.print 'View first 10 observations'
-- View first 10 observations
SELECT * FROM FloridaInsurance LIMIT 10;





-- ******************
-- How many unique values of a certain variable?
-- ******************
.print ' '
.print 'Unique values'
-- Number of unique counties in the data (lists a number)
SELECT count(distinct county) from FloridaInsurance;





-- ******************
-- Average margin of victory?
-- ******************
.print ' '
.print 'Margin of victory'
-- Create new column which is the Wscore-Lscore difference, then find the average of it
SELECT AVG(tiv_2012-tiv_2011) FROM FloridaInsurance;


-- ******************
-- Distribution of categories
-- ******************
.print ' '
.print 'Categorical distribution'
-- Frequency table of construction
SELECT construction, COUNT(*) FROM FloridaInsurance GROUP BY construction;


-- ******************
-- Save as text file
-- ******************
.output PS3_Townsend.sqlite3
.dump


-- ProTip: You can execute this file from the Linux command line by issuing the following:
-- sqlite3 < PS3_Townsend.sql > PS3_Townsend.sqlog
