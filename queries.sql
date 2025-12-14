use final_project;
-- - what are the number of each subtype of common theft in the month with the highest rated episode?
select reportedcrime.year, reportedcrime.month, mode, type, subtype, sum(crimecount) as "number reported" from reportedcrime
inner join 
	(select year, month from dragonballratings
	order by rating desc
	limit 1) highest_rated_month on reportedcrime.year = highest_rated_month.year and reportedcrime.month = highest_rated_month.month
where reportedcrime.mode = "COMMON THEFT"
group by reportedcrime.year, reportedcrime.month, mode, type, subtype;

-- - what are the number of each subtype of common theft in the month with the lowest rated episode?
select reportedcrime.year, reportedcrime.month, mode, type, subtype, sum(crimecount) as "number reported" from reportedcrime
inner join 
	(select year, month from dragonballratings
	order by rating asc
	limit 1) highest_rated_month on reportedcrime.year = highest_rated_month.year and reportedcrime.month = highest_rated_month.month
where reportedcrime.mode = "COMMON THEFT"
group by reportedcrime.year, reportedcrime.month, mode, type, subtype;

-- - what was the average episode rating in the month with the lowest number of reported common thefts?
select year, month, avg(rating) as "average rating" from dragonballratings
where year = 
	(select year from 
	(select season, episode, dragonballratings.year, dragonballratings.month, rating, total_count from dragonballratings 
	inner join
		(select reportedcrime.year, reportedcrime.month, mode, sum(crimecount) as total_count from reportedcrime
				where reportedcrime.mode = "COMMON THEFT"
				group by reportedcrime.year, reportedcrime.month, mode
				order by total_count) common_theft
	on dragonballratings.year = common_theft.year and dragonballratings.month = common_theft.month
	order by total_count asc limit 1) lowest_year_month)
and
	month = 
    (select month from 
	(select season, episode, dragonballratings.year, dragonballratings.month, rating, total_count from dragonballratings 
	inner join
		(select reportedcrime.year, reportedcrime.month, mode, sum(crimecount) as total_count from reportedcrime
				where reportedcrime.mode = "COMMON THEFT"
				group by reportedcrime.year, reportedcrime.month, mode
				order by total_count) common_theft
	on dragonballratings.year = common_theft.year and dragonballratings.month = common_theft.month
	order by total_count asc limit 1) lowest_year_month)
group by year, month;

-- - for each month from 1997-2003, list the number of reported common thefts (graph)
select year, month, sum(crimecount) as "number reported" from reportedcrime
where mode = "COMMON THEFT" and year >= 1997 and year <= 2003
group by year, month
order by year asc;

-- - for each month from 1997-2003, list the average episode rating (graph)
select year, month, avg(rating) as "average rating" from dragonballratings
where year >= 1995
group by year, month;

-- - how many episodes were released in the month with the lowest number of reported common thefts?
select count(*) as "number of episodes" from dragonballratings
where year = 
	(select year from 
	(select season, episode, dragonballratings.year, dragonballratings.month, rating, total_count from dragonballratings 
	inner join
		(select reportedcrime.year, reportedcrime.month, mode, sum(crimecount) as total_count from reportedcrime
				where reportedcrime.mode = "COMMON THEFT"
				group by reportedcrime.year, reportedcrime.month, mode
				order by total_count) common_theft
	on dragonballratings.year = common_theft.year and dragonballratings.month = common_theft.month
	order by total_count asc limit 1) lowest_year_month)
and
	month = 
    (select month from 
	(select season, episode, dragonballratings.year, dragonballratings.month, rating, total_count from dragonballratings 
	inner join
		(select reportedcrime.year, reportedcrime.month, mode, sum(crimecount) as total_count from reportedcrime
				where reportedcrime.mode = "COMMON THEFT"
				group by reportedcrime.year, reportedcrime.month, mode
				order by total_count) common_theft
	on dragonballratings.year = common_theft.year and dragonballratings.month = common_theft.month
	order by total_count asc limit 1) lowest_year_month);

-- - how many episodes were released in the month with the highest number of reported common thefts?
select count(*) as "number of episodes" from dragonballratings
where year = 
    (select year from 
    (select season, episode, dragonballratings.year, dragonballratings.month, rating, total_count from dragonballratings 
    inner join
        (select reportedcrime.year, reportedcrime.month, mode, sum(crimecount) as total_count from reportedcrime
                where reportedcrime.mode = "COMMON THEFT"
                group by reportedcrime.year, reportedcrime.month, mode
                order by total_count desc) common_theft
    on dragonballratings.year = common_theft.year and dragonballratings.month = common_theft.month
    order by total_count desc limit 1) highest_year_month)
and
    month = 
    (select month from 
    (select season, episode, dragonballratings.year, dragonballratings.month, rating, total_count from dragonballratings 
    inner join
        (select reportedcrime.year, reportedcrime.month, mode, sum(crimecount) as total_count from reportedcrime
                where reportedcrime.mode = "COMMON THEFT"
                group by reportedcrime.year, reportedcrime.month, mode
                order by total_count desc) common_theft
    on dragonballratings.year = common_theft.year and dragonballratings.month = common_theft.month
    order by total_count desc limit 1) highest_year_month);

-- - for each year from 1997-2003, list the unemployment rate and gdp in mexico
select * from mexicounemployment
where year >= 1997 and year <= 2003;
select * from mexicogdp
where year >= 1997 and year <= 2003;

-- - which year had the highest number of reported crimes, and what was the gdp that year?
select reportedcrime.year, sum(crimecount) as total_crimes, mexicogdp.gdp from reportedcrime
inner join mexicogdp on reportedcrime.year = mexicogdp.year
where mode = "COMMON THEFT"
group by reportedcrime.year, mexicogdp.gdp
order by total_crimes desc limit 1;

-- - which year had the highest number of reported crimes, and what was the unemployment rate that year?
select reportedcrime.year, sum(crimecount) as total_crimes, mexicounemployment.unemployment from reportedcrime
inner join mexicounemployment on reportedcrime.year = mexicounemployment.year
where mode = "COMMON THEFT"
group by reportedcrime.year, mexicounemployment.unemployment
order by total_crimes desc limit 1;

-- - which year had the highest number of reported crimes, and who was the president that year?
select presidentterms.*, highest_crime.year as highest_crime_year, highest_crime.total_crimes 
from presidentterms
join (
    select reportedcrime.year, sum(crimecount) as total_crimes from reportedcrime
    where mode = "COMMON THEFT"
    group by reportedcrime.year
    order by total_crimes desc limit 1
) highest_crime
on presidentterms.start <= highest_crime.year and presidentterms.end >= highest_crime.year;

-- - which year had the highest number of reported crimes, and what was the president’s approval rating that year?
SELECT reportedcrime.year,
	pt.name,
    par.rating,
	SUM(reportedcrime.Crimecount) as TotalCrime
    from reportedcrime
    inner join presidentialapprovalratings as par on par.year = reportedcrime.year
    inner join presidentterms as pt on pt.pid = par.pid
    group by reportedcrime.year,
    pt.name,
    par.rating
    order by TotalCrime desc
    limit 1;

-- - which year had the highest gdp, and what was the number of reported crimes that year?
SELECT reportedcrime.year,
	gdp.GDP,
	SUM(reportedcrime.Crimecount) as TotalCrime
    from reportedcrime
    inner join mexicogdp as gdp on gdp.year = reportedcrime.year
    group by reportedcrime.year, gdp.GDP
    order by gdp.GDP desc
    limit 1;
    

-- - what was the most common type of reported crime in the year with the highest gdp?
SELECT reportedcrime.year,
	gdp.GDP,
    reportedcrime.mode,
	SUM(reportedcrime.CrimeCount) as CrimeCounts
    from reportedcrime
    inner join mexicogdp as gdp on gdp.year = reportedcrime.year
    group by reportedcrime.year, gdp.GDP, reportedcrime.mode
    order by gdp.GDP desc, CrimeCounts desc
    limit 1;

-- - in the month with the lowest rated episode, what was the most common type of crime?
SELECT dragonballratings.year,
dragonballratings.month,
dragonballratings.title,
dragonballratings.rating,
subquery.mode,
subquery.CrimeTotals
from (
	SELECT reportedcrime.year,
	reportedcrime.month,
	reportedcrime.mode,
	SUM(reportedcrime.crimecount) as Crimetotals
	from reportedcrime
	group by reportedcrime.year,
	reportedcrime.month,
	reportedcrime.mode
) as subquery
inner join dragonballratings on dragonballratings.year = subquery.year
where dragonballratings.month = subquery.month
group by dragonballratings.year,
dragonballratings.month,
dragonballratings.title,
dragonballratings.rating, subquery.mode, subquery.CrimeTotals
order by dragonballratings.rating asc, subquery.Crimetotals desc
limit 1;

-- - what was the most common type of reported crime in the year with the highest unemployment?
SELECT reportedcrime.year,
	u.unemployment,
    reportedcrime.mode,
	SUM(reportedcrime.CrimeCount) as CrimeCounts
    from reportedcrime
    inner join mexicounemployment as u on u.year = reportedcrime.year
    group by reportedcrime.year, u.unemployment, reportedcrime.mode
    order by u.unemployment desc, CrimeCounts desc
    limit 1;

-- - what was the most common type of reported crime in the year with the lowest gdp?
SELECT reportedcrime.year,
	gdp.GDP,
    reportedcrime.mode,
	SUM(reportedcrime.CrimeCount) as CrimeCounts
    from reportedcrime
    inner join mexicogdp as gdp on gdp.year = reportedcrime.year
    group by reportedcrime.year, gdp.GDP, reportedcrime.mode
    order by gdp.GDP asc, CrimeCounts desc
    limit 1;

-- - what was the most common type of reported crime in the year with the lowest unemployment?
SELECT reportedcrime.year,
	u.unemployment,
    reportedcrime.mode,
	SUM(reportedcrime.CrimeCount) as CrimeCounts
    from reportedcrime
    inner join mexicounemployment as u on u.year = reportedcrime.year
    group by reportedcrime.year, u.unemployment, reportedcrime.mode
    order by u.unemployment asc, CrimeCounts desc
    limit 1;

