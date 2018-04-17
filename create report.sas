   /*************************************/
   /* create input data set 1           */
   /*************************************/
data exprev;
   input Region $ State $ Month monyy5.
         Expenses Revenues;
   format month monyy5.;
   datalines;
Southern GA JAN95 2000  8000
Southern GA FEB95 1200  6000
Southern FL FEB95 8500 11000
Northern NY FEB95 3000  4000
Northern NY MAR95 6000  5000
Southern FL MAR95 9800 13500
Northern MA MAR95 1500  1000
;
run;
   /*************************************/
   /* subset and print the data set     */
   /*************************************/
proc print data=exprev double;
   var month state revenues;
   where region='Southern' and revenues>=8000;
   title1 'High Monthly Revenues for';
   title2 'the Southern Region';
run;
   /*************************************/
   /* create input data set 2           */
   /*************************************/
data pilots;
   infile datalines;
   input ID $ 1-4 LastName $ 6-15 FirstName $ 17-25
         City $ 27-38 State $ 40-41 Gender $ 43
         JobCode $ 45-47 @49 Salary @56;
   datalines;
1333 BLAIR      JUSTIN    STAMFORD     CT M PT2  88606
1739 BOYCE      JONATHAN  NEW YORK     NY M PT1  66517
1428 BRADY      CHRISTINE STAMFORD     CT F PT1  68767
1404 CARTER     DONALD    NEW YORK     NY M PT2  91376
1118 DENNIS     ROGER     NEW YORK     NY M PT3 111379
1905 GRAHAM     ALVIN     NEW YORK     NY M PT1  65111
1407 GRANT      DANIEL    MT. VERNON   NY M PT1  68096
1410 HARRIS     CHARLES   STAMFORD     CT M PT2  84685
1439 HARRISON   FELICIA   BRIDGEPORT   CT F PT1  70736
1545 HUNTER     CLYDE     STAMFORD     CT M PT1  66130
1777 LUFKIN     ROY       NEW YORK     NY M PT3 109630
1106 MARSHBURN  JASPER    STAMFORD     CT M PT2  89632
1333 NEWKIRK    SANDRA    PRINCETON    NJ F PT2  84536
1478 NEWTON     JAMES     NEW YORK     NY M PT2  84203
1556 PENNINGTON MICHAEL   NEW YORK     NY M PT1  71349
1890 STEPHENSON ROBERT    NEW YORK     NY M PT2  85896
1107 THOMPSON   WAYNE     NEW YORK     NY M PT2  89977
1830 TRIPP      KATHY     BRIDGEPORT   CT F PT2  84471
1928 UPCHURCH   LARRY     WHITE PLAINS NY M PT2  89858
1076 VENTER     RANDALL   NEW YORK     NY M PT1  66558
;
run;

   /*************************************/
   /* set system options for report     */
   /*************************************/
options nodate pageno=1 linesize=64 pagesize=60;

   /*************************************/
   /* sort the data and create a        */
   /* temporary output data set         */
   /*************************************/
proc sort data=pilots out=tempemp;
   by jobcode gender;
run;
	   
   /*************************************/
   /* print the sorted data set         */
   /*************************************/
proc print data=tempemp split='*';
   id jobcode;
   by jobcode;
   var gender salary;
   sum salary;
   label jobcode='Job Code*========'
         gender='Gender*======'
         salary='Annual Salary*=============';
   format salary dollar11.2;
   where jobcode in ('PT1','PT2');
   title 'Expenses Incurred for';
   title2 'Salaries for Pilots';	
run;

   /*************************************/
   /* clear any titles in effect        */
   /*************************************/
title;
 
