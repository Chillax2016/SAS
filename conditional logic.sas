   /*************************************/
   /* conditional logic with            */
   /* IF-THEN/ELSE                      */
   /*************************************/
data payroll;
   input IdNumber $ 1-4 Sex $ 6 Jobcode $ 8-10
         Salary 12-16 @18 Birth date7. 
         @26 Hired date7.;
   if jobcode='ME2' then
      Group='Mechanics'; 
   else if jobcode='PT1' then
        Group='Pilots';
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

data highwage;
   set payroll(drop=sex birth hired);
   if salary>60000 then
      Category="High";
   else if salary<30000 then
        Category="Low";
   else Category="Avg";
run;
   /*************************************/
   /* other examples of IF-THEN/ELSE    */
   /* (code fragments)                  */
   /*************************************/
if x then delete;

if status='OK' and type=3 then count+1;

if age ne agecheck then delete;

/*该例显示了嵌套的 IF-THEN 结构。*/
if x=0 then 
   if y ne 0 then put 'X ZERO, Y NONZERO'; 
   else put 'X ZERO, Y ZERO';
else put 'X NONZERO';

/*该例显示了 IF-THEN 结构内的 DO 子组。*/
if answer=9 then
   do;
      answer=.;
      put 'INVALID ANSWER FOR ' id=;
   end;
else
   do;
      answer=answer10;
      valid+1;
   end;

   /*************************************/
   /* conditional logic with SELECT     */
   /* (code fragment)                   */
   /*************************************/

   /*若有一系列互斥条件，则使用 SELECT 组要比使用一系列 IF-THEN/ELSE 语句更有效，
   因为这样可以缩短 CPU 处理时间。
   SELECT 组还可让程序便于读取和调试。*/
select (payclass);
   when ('monthly') amt=salary;
   when ('hourly')
      do;
         amt=hrlywage*min(hrs,40);
         if hrs>40 then put 'CHECK TIMECARD';
      end;         /* end of do     */
   otherwise put 'PROBLEM OBSERVATION';
end;               /* end of select */

   /*************************************/
   /* conditional logic with subsetting */
   /* IF                                */
   /*************************************/
data mechanics;   
set payroll;   
if jobcode='ME2';
run;
 
