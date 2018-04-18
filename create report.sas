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
proc print data=exprev double;/*DOUBLE 选项在两个观测之间加写一个空行。（该选项对 HTML 输出不起作用。） */
   var month state revenues;/*VAR 语句按此顺序创建 Month、State 和 Revenues 的列。*/
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
/*PROC SORT 将对 DATA= 选项中指定的数据集永久排序。
若不希望永久对数据排序，则必须指定 OUT= 选项，创建包含排序数据的输出数据集。
若只需对一个 SAS 会话中的数据排序并生成输出，则应指定一个临时 SAS 数据集作为输出数据集。

BY 语句是 PROC SORT 要求一同使用的语句，该语句指定的变量值用于对数据排序。
此处观测按 JobCode 和 Gender 排序。*/
proc sort data=pilots out=tempemp;
   by jobcode state gender;
run;
	   
   /*************************************/
   /* print the sorted data set         */
   /*************************************/
proc print data=tempemp 
   split='*';/*SPLIT= 选项将星号标识为列标题中新起一行的字符。*/
   id jobcode;/*ID 语句使用所列变量的格式化值而不是观测号来标识观测。*/
   by jobcode;/*BY 语句将为每个 BY 组生成单独一段报表。
   若所有 BY 变量都以相同的顺序出现在 ID 语句的开头，则 PROC PRINT 将使用一种特殊布局*/
   var state gender salary;/*VAR 语句选择将出现在报表中的变量，并确定它们的顺序。
   VAR 语句与 ID 语句共同选择要纳入报表的变量*/
   sum salary;/*SUM 语句将对数值变量的值计算合计。*/
   label jobcode='Job Code*========'
         state='State Code*========='
         gender='Gender*======'
         salary='Annual Salary*=============';
   format salary dollar11.2;/*FORMAT 语句指定输出格式。*/
   where jobcode in ('PT1','PT2','PT3');
   title 'Expenses Incurred for';
   title2 'Salaries for Pilots';	
run;

   /*************************************/
   /* clear any titles in effect        */
   /*************************************/
title;
 
