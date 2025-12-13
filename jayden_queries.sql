use final_project;
-- - [ ]  what are the number of reported crimes in the year and month with the highest rated episode?
SELECT yr, SUM(CASE (SELECT month FROM dragonballratings ORDER BY rating DESC LIMIT 1)
        WHEN 1 THEN JANUARY
        WHEN 2 THEN FEBRUARY
        WHEN 3 THEN MARCH
        WHEN 4 THEN APRIL
        WHEN 5 THEN MAY
        WHEN 6 THEN JUNE
        WHEN 7 THEN JULY
        WHEN 8 THEN AUGUST
        WHEN 9 THEN SEPTEMBER
        WHEN 10 THEN OCTOBER
        WHEN 11 THEN NOVEMBER
        WHEN 12 THEN DECEMBER
    END) AS total_crimes_in_month 
FROM crimerate
WHERE yr = (SELECT year FROM dragonballratings ORDER BY rating DESC LIMIT 1)
GROUP BY yr;

-- - [ ]  what was the average episode rating in the month with the lowest number of reported crimes?
SELECT 
    month_name,
    yr AS year_with_lowest_crimes,
    total_crimes
FROM (
    SELECT 'JANUARY' AS month_name, yr, SUM(JANUARY) AS total_crimes,
           ROW_NUMBER() OVER (ORDER BY SUM(JANUARY) ASC) AS rn
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'FEBRUARY', yr, SUM(FEBRUARY),
           ROW_NUMBER() OVER (ORDER BY SUM(FEBRUARY) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'MARCH', yr, SUM(MARCH),
           ROW_NUMBER() OVER (ORDER BY SUM(MARCH) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'APRIL', yr, SUM(APRIL),
           ROW_NUMBER() OVER (ORDER BY SUM(APRIL) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'MAY', yr, SUM(MAY),
           ROW_NUMBER() OVER (ORDER BY SUM(MAY) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'JUNE', yr, SUM(JUNE),
           ROW_NUMBER() OVER (ORDER BY SUM(JUNE) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'JULY', yr, SUM(JULY),
           ROW_NUMBER() OVER (ORDER BY SUM(JULY) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'AUGUST', yr, SUM(AUGUST),
           ROW_NUMBER() OVER (ORDER BY SUM(AUGUST) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'SEPTEMBER', yr, SUM(SEPTEMBER),
           ROW_NUMBER() OVER (ORDER BY SUM(SEPTEMBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'OCTOBER', yr, SUM(OCTOBER),
           ROW_NUMBER() OVER (ORDER BY SUM(OCTOBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'NOVEMBER', yr, SUM(NOVEMBER),
           ROW_NUMBER() OVER (ORDER BY SUM(NOVEMBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'DECEMBER', yr, SUM(DECEMBER),
           ROW_NUMBER() OVER (ORDER BY SUM(DECEMBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
) monthly_data
inner join 
	(select year, month, avg(rating) from dragonballratings
	where year >= 1995
	group by year, month) as ratings
on monthly_data.yr = ratings.year and monthly_data.month_name = 
    CASE ratings.month
        WHEN 1 THEN 'JANUARY'
        WHEN 2 THEN 'FEBRUARY'
        WHEN 3 THEN 'MARCH'
        WHEN 4 THEN 'APRIL'
        WHEN 5 THEN 'MAY'
        WHEN 6 THEN 'JUNE'
        WHEN 7 THEN 'JULY'
        WHEN 8 THEN 'AUGUST'
        WHEN 9 THEN 'SEPTEMBER'
        WHEN 10 THEN 'OCTOBER'
        WHEN 11 THEN 'NOVEMBER'
        WHEN 12 THEN 'DECEMBER'
    END
WHERE rn = 1;

-- - [ ]  for each month from 1997-2003, list the number of reported crimes (graph)
select yr, sum(JANUARY), sum(FEBRUARY), sum(MARCH), sum(APRIL), sum(MAY), sum(JUNE), sum(JULY), sum(AUGUST), sum(SEPTEMBER), sum(OCTOBER), sum(NOVEMBER), sum(DECEMBER) from crimerate
where yr >= 1995 and yr <= 2003
group by yr;

-- for each month from 1997-2003, list the average episode rating (graph)
select year, month, avg(rating) from dragonballratings
where year >= 1995
group by year, month;

-- - [ ]  how many episodes were released in the month with the lowest number of reported crimes?
SELECT 
    month_name,
    yr AS year_with_lowest_crimes,
    total_crimes, numeps
FROM (
    SELECT 'JANUARY' AS month_name, yr, SUM(JANUARY) AS total_crimes,
           ROW_NUMBER() OVER (ORDER BY SUM(JANUARY) ASC) AS rn
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'FEBRUARY', yr, SUM(FEBRUARY),
           ROW_NUMBER() OVER (ORDER BY SUM(FEBRUARY) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'MARCH', yr, SUM(MARCH),
           ROW_NUMBER() OVER (ORDER BY SUM(MARCH) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'APRIL', yr, SUM(APRIL),
           ROW_NUMBER() OVER (ORDER BY SUM(APRIL) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'MAY', yr, SUM(MAY),
           ROW_NUMBER() OVER (ORDER BY SUM(MAY) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'JUNE', yr, SUM(JUNE),
           ROW_NUMBER() OVER (ORDER BY SUM(JUNE) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'JULY', yr, SUM(JULY),
           ROW_NUMBER() OVER (ORDER BY SUM(JULY) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'AUGUST', yr, SUM(AUGUST),
           ROW_NUMBER() OVER (ORDER BY SUM(AUGUST) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'SEPTEMBER', yr, SUM(SEPTEMBER),
           ROW_NUMBER() OVER (ORDER BY SUM(SEPTEMBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'OCTOBER', yr, SUM(OCTOBER),
           ROW_NUMBER() OVER (ORDER BY SUM(OCTOBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'NOVEMBER', yr, SUM(NOVEMBER),
           ROW_NUMBER() OVER (ORDER BY SUM(NOVEMBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
    UNION ALL
    SELECT 'DECEMBER', yr, SUM(DECEMBER),
           ROW_NUMBER() OVER (ORDER BY SUM(DECEMBER) ASC)
    FROM crimerate WHERE yr >= 1995 AND yr <= 2003 GROUP BY yr
) monthly_data
inner join 
	(select year, month, count(*) as numeps from dragonballratings
    group by year, month) as episodecount
on monthly_data.yr = episodecount.year and monthly_data.month_name = 
    CASE episodecount.month
        WHEN 1 THEN 'JANUARY'
        WHEN 2 THEN 'FEBRUARY'
        WHEN 3 THEN 'MARCH'
        WHEN 4 THEN 'APRIL'
        WHEN 5 THEN 'MAY'
        WHEN 6 THEN 'JUNE'
        WHEN 7 THEN 'JULY'
        WHEN 8 THEN 'AUGUST'
        WHEN 9 THEN 'SEPTEMBER'
        WHEN 10 THEN 'OCTOBER'
        WHEN 11 THEN 'NOVEMBER'
        WHEN 12 THEN 'DECEMBER'
    END
WHERE rn = 1;

-- - [ ]  for each year from 1997-2003, list the unemployment rate and gdp in mexico
SELECT countryname, `1997`, `1998`, `1999`, `2000`, `2001`, `2002`, `2003`
FROM unemploymentcountries
WHERE countryname = "Mexico";
SELECT countryname, `1997`, `1998`, `1999`, `2000`, `2001`, `2002`, `2003`
FROM countriesgdp
WHERE countryname = "Mexico";

-- - [ ]  which year between 1997-2003 had the highest number of reported crimes, and what was the gdp that year?
SELECT yr FROM
	(SELECT yr, 
		   SUM(JANUARY + FEBRUARY + MARCH + APRIL + MAY + JUNE + JULY + AUGUST + SEPTEMBER + OCTOBER + NOVEMBER + DECEMBER) AS total_crimes
	FROM crimerate
	GROUP BY yr
	ORDER BY total_crimes DESC) as highestcrimeyr
where yr >= 1997 and yr <= 2003; -- returns 1997
SELECT `1997` FROM countriesgdp where countryname = "Mexico";

-- - [ ]  which year had the highest number of reported crimes, and what was the unemployment rate that year?
SELECT `1997` FROM unemploymentcountries where countryname = "Mexico";

-- - [ ]  which year had the highest number of reported crimes, and who was the president that year?
select name from presidentterms
where 1997 between start and end;