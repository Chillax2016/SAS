   /*************************************/
   /* join tables (inner join)          */
   /*************************************/

proc sql;
title 'Oil Production/Reserves of Countries';
select 
p.country, 
barrelsperday 'Production' ,
barrels 'Reserves'
from oilprod p , oilrsrvs r
where p. country = r.country
order by barrelsperday desc;
quit;

   /*************************************/
   /* join tables (left outer join)     */
   /*************************************/
proc sql;
title;
select 
capital format =$20.,
name 'country' format = $20.,
latitude,
longitude
from
countries a left join
worldcitycoords b 
on a.capital=b.city and a.name = b.country
order by capital;
quit;

   /*************************************/
   /* join tables (full outer join)     */
   /*************************************/
proc sql;
   title 'Populations/Coordinates of World Cities';
   select City '#City#(WORLDCITYCOORDS)' format=$20.,
          Capital '#Capital#(COUNTRIES)' format=$20.,
          Population, Latitude, Longitude
      from countries full join 
           worldcitycoords
           on Capital = City and
              Name = Country; 
quit;

   /*************************************/
   /* clear any titles in effect        */
   /*************************************/
title;
 
