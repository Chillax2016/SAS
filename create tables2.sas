/*
修改表的几乎所有特性 
计算百分数 
生成子报表，而不必对数据排序 
一步完成汇总数据并生成报表 
一步生成多个表

PROC TABULATE 还可计算其他描述性统计过程（如 MEANS、FREQ 和 REPORT）可计算的许多统计量。
*/

   /*************************************/
   /* create the first input data set   */
   /*************************************/
data wghtclub; 
   input idno 1-4 name $ 6-24 team $ strtwght endwght; 
   loss=strtwght-endwght; 
   datalines; 
1023 David Shaw         red 189 165 
1049 Amelia Serrano     yellow 145 124 
1219 Alan Nance         red 210 192 
1246 Ravi Sinha         yellow 194 177 
1078 Ashley McKnight    red 127 118 
run; 

   /*************************************/
   /* print the data set                */
   /*************************************/
proc print data=wghtclub; 
   title 'Health Club Data'; 
run; 
 
   /*************************************/
   /* create a two-dimensional table    */
   /*************************************/
ods listing;
proc tabulate data=wghtclub; 
	/*CLASS 语句将 Team 标识为分类变量。*/
	class team; 
	/*VAR 语句将 Strtwght、Endwght 和 Loss 标识为分析变量。*/
	var strtwght endwght loss; 
	/*这两个表语句使用相同的元素（变量和统计量），但生成的表布局却有所不同。*/
	table team, mean*(strtwght endwght loss);
	table mean*(strtwght endwght loss), team; 
	title 'Mean Starting Weight, Ending Weight,and Weight Loss'; 
run; 
ods listing close;

   /*************************************/
   /* create the second input data set  */
   /*************************************/

data patients;
   input ID $ 1-4 Name $ 6-16 Sex $ 18 Age 20-21 
         Date 23-24 Height 26-27 Weight 29-31 
		 ActLevel $ 33-36 Fee 38-43;
   format fee 6.2; 
   datalines;
2458 Murray, W   M 27  1 72 168 HIGH  85.20
2462 Almers, C   F 34  3 66 152 HIGH 124.80
2523 Johnson, R  F 43 31 63 137 MOD  149.75
2539 LaMance, K  M 51  4 71 158 LOW  124.80
2544 Jones, M    M 29  6 76 193 HIGH 124.80
2552 Reberson, P F 32  9 67 151 MOD  149.75
2555 King, E     M 35 13 70 173 MOD  149.75
2563 Pitts, D    M 34 22 73 154 LOW  124.80
2571 Nunnelly, A F 44 19 66 140 HIGH 149.75
2572 Oberon, M   F 28 17 62 118 LOW   85.20
2574 Peterson, V M 30  6 69 147 MOD  149.75
2575 Quigley, M  F 40  8 69 163 HIGH 124.80
2578 Cameron, L  M 47  5 72 173 MOD  124.80
2586 Derber, B   M 25 23 75 188 HIGH  85.20
2588 Ivan, H     F 22 20 63 139 LOW   85.20
2589 Wilcox, E   F 41 16 67 141 HIGH 149.75
2595 Warren, C   M 54  7 71 183 MOD  149.75
;
run;

   /*************************************/
   /* specify HTML output               */
   /*************************************/
ods html body='table.htm' style=default;

   /*************************************/
   /* create a two-dimensional table    */
   /* with style elements specified     */
   /*************************************/
proc tabulate data=patients 
style=[font_weight=bold];/*bold 字体加粗*/   
class actlevel;/*分类变量*/
classlev actlevel / style=[just=left];   
var age height weight / style=[font_size=3];/*分析变量*/   
keyword all sum / style=[font_width=wide];   
keylabel all="All Patients";   
table (actlevel="Activity Level" 
all*[style=[background=yellow]]),
(age height weight*f=best10.2)*mean /style=[background=white]         
misstext=[label="Missing"/style=[font_weight=light]]         
box=[label="Patient Info by Activity Level"          
style=[font_style=italic]];
title 'Enhanced Table';
run;

   /*************************************/
   /* close the HTML destination        */
   /*************************************/
   ods html close;
   /*************************************/
   /* clear any titles in effect        */
   /*************************************/ 
title;
 
