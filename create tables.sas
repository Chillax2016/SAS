   /*************************************/
   /* create the input data set         */
   /*************************************/

/*@@
两个都是行控制符
@  表示执行下一个操作时，指针移到下一个记录。写一个@就是到这里中断，剩下的不管
@@表示执行下一个操作，指针保持在当前记录。写两个@@就是到这里为一行，剩下的在数据集里另起一行继续写入*/

data color;
   input Region Eyes $ Hair $ Count @@;/*这里的@@*/
   label eyes='Eye Color'
         hair='Hair Color'
         region='Geographic Region';
   datalines;
1 blue  fair    23  1 blue  red      7  1 blue  medium  24
1 blue  dark    11  1 green fair    19  1 green red      7
1 green medium  18  1 green dark    14  1 brown fair    34
1 brown red      5  1 brown medium  41  1 brown dark    40
1 brown black    3  2 blue  fair    46  2 blue  red     21
2 blue  medium  44  2 blue  dark    40  2 blue  black    6
2 green fair    50  2 green red     31  2 green medium  37
2 green dark    23  2 brown fair    56  2 brown red     42
2 brown medium  53  2 brown dark    54  2 brown black   13
;
run;
   /*************************************/
   /* create simple frequency tables    */
   /*************************************/
proc freq data=color;
/*TABLES 语句需要两个表：Eyes 和 Hair 频数。
默认情况下，表中将显示指定变量每个值的频数、百分比、累积频数和累积百分比。*/
tables eyes hair;
title1 'Simple Frequency Tables';
run;

   /*************************************/
   /* create a crosstabulation table    */
   /* and an output data set            */
   /*************************************/
/*TABLES 语句要求 Eyes 对 Hair 的交叉制表。
OUT= 创建包含交叉表频数的 FREQCNT 数据集。
OUTEXPECT 存储期望单元格频数。
SPARSE 存储 FREQCNT 中的零单元格计数。*/
proc freq data=color;
   weight count;
   tables eyes*hair/out=freqcnt outexpect
          sparse;
   title1 'Crosstabulation Table';
run;

   /*************************************/
   /* print the output data set         */
   /*************************************/ 
proc print data=freqcnt noobs;
   title2 'Output Data Set from PROC FREQ';
run;

   /*************************************/
   /* clear any titles in effect        */
   /*************************************/ 
title;

 
/*@@
两个都是行控制符
@  表示执行下一个操作时，指针移到下一个记录。
@@表示执行下一个操作，指针保持在当前记录。*/

data a;
  input x y @;
  cards;
  1 2 3 4
  2 2 3 5
  3 2 1 1
  ;run;
proc print data=a;run;
data b;
  input x y @@;
  cards;
  1 2 3 4
  2 2 3 5
  3 2 1 1
  ;run;
proc print data=b;run;
