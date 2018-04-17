   /*************************************/
   /* set system options for report     */
   /*************************************/
options nodate nonumber; 
   /*************************************/
   /* create temporary data set         */
   /*************************************/
data test;
   Time1=86399;
   format Time1 datetime.;
   Date1=86399;
   format Date1 date.;
   Time2=86399;
   format Time2 timeampm.;
   Date1Month=month(Date1);
run;
   /*************************************/
   /* print data set                    */
   /*************************************/
proc print data=test noobs;
   title 'Same Number, Different SAS Values';
   footnote1 'Time1 is a SAS DATETIME value.';
   footnote2 'Date1 is a SAS DATE value.';
   footnote3 'Time2 is a SAS TIME value.';
   footnote4 'Date1Month is the numeric month for Date1.';
run;

   /*************************************/
   /* clear any titles and footnotes    */
   /* in effect                         */
   /*************************************/
title;
footnote;

   /*************************************/
   /* set system options for report     */
   /*************************************/
options nodate nonumber;

   /*************************************/
   /* create temporary data set         */
   /*************************************/
data meeting;
   input region $ mtg : mmddyy10.;
   sendmail=mtg-45;
   datalines;
N  11-24-99
S  12-28-99
E  12-03-99
W  10-04-99
;
run;
   /*************************************/
   /* print data set                    */
   /*************************************/

proc print data=meeting noobs;
   format mtg sendmail date9.;
   title 'When to Send Announcements';
run;

   /*************************************/
   /* clear any titles in effect        */
   /*************************************/
title;
 
