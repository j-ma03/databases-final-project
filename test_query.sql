use final_project;
select * from presidentterms;
select * from crimerate;
-- select * from countriesgdp;
-- select * from presidentialapprovalratings;
select * from dragonballratings;
-- select * from unemploymentcountries;

select yr, sum(JANUARY), sum(FEBRUARY), sum(MARCH), sum(APRIL), sum(MAY), sum(JUNE), sum(JULY), sum(AUGUST), sum(SEPTEMBER), sum(OCTOBER), sum(NOVEMBER), sum(DECEMBER) from crimerate
where yr >= 1995 and yr <= 2003
group by yr;

select year, month, avg(rating) from dragonballratings
group by year, month;

