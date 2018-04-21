   /*************************************/
   /* create the input table (data set) */
   /*************************************/

data payroll;
input Idnumber $ 1-4 Sex $ 6 Jobcode $ 8-10 Salary 12-16 
@18 Birth date7.
@26 Hired date7.;
format birth hired mmddyy8.;
datalines;
1009 M TA1 28880 02MAR59 26MAR92
1017 M TA3 40858 28DEC57 16OCT81
1036 F TA3 39392 19MAY65 23OCT84
1037 F TA1 28558 10APR64 13SEP92
1038 F TA1 26533 09NOV69 23NOV91
1050 M ME2 35167 14JUL63 24AUG86
1065 M ME2 35090 26JAN44 07JAN87
1076 M PT1 66558 14OCT55 03OCT91
1094 M FA1 22268 02APR70 17APR91
1100 M BCK 25004 01DEC60 07MAY88
;
run;

   /*************************************/
   /* retrieve data using a query       */
   /*************************************/
proc sql;
select Jobcode, count(Jobcode) as number label = 'Number',
avg(int(today()-birth)/365.25) as avgage format = 2. label='Average age',
avg(salary) as avgsal format = dollar8. label ='Average salary'
from payroll
group by Jobcode
having avgage ge 30;
title1 'Summary Information for Each Job Category';
title2 'Average Age 30 or Over';
quit;

   /*************************************/
   /* create a new table from a query   */
   /*************************************/

proc sql;
create table bonus as
select 
IdNumber,
Salary format = dollar8.,
salary * 0.25 as Bonus fomat = dollar8.
from payroll;
title 'BONUS Information';

select * from bonus;
quit;

   /*************************************/
   /* clear any titles in effect        */
   /*************************************/
title;


