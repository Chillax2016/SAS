   /*************************************/
   /* create the input data set         */
   /*************************************/

/*@@
���������п��Ʒ�
@  ��ʾִ����һ������ʱ��ָ���Ƶ���һ����¼��дһ��@���ǵ������жϣ�ʣ�µĲ���
@@��ʾִ����һ��������ָ�뱣���ڵ�ǰ��¼��д����@@���ǵ�����Ϊһ�У�ʣ�µ������ݼ�������һ�м���д��*/

data color;
   input Region Eyes $ Hair $ Count @@;/*�����@@*/
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
/*TABLES �����Ҫ������Eyes �� Hair Ƶ����
Ĭ������£����н���ʾָ������ÿ��ֵ��Ƶ�����ٷֱȡ��ۻ�Ƶ�����ۻ��ٷֱȡ�*/
tables eyes hair;
title1 'Simple Frequency Tables';
run;

   /*************************************/
   /* create a crosstabulation table    */
   /* and an output data set            */
   /*************************************/
/*TABLES ���Ҫ�� Eyes �� Hair �Ľ����Ʊ�
OUT= �������������Ƶ���� FREQCNT ���ݼ���
OUTEXPECT �洢������Ԫ��Ƶ����
SPARSE �洢 FREQCNT �е��㵥Ԫ�������*/
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
���������п��Ʒ�
@  ��ʾִ����һ������ʱ��ָ���Ƶ���һ����¼��
@@��ʾִ����һ��������ָ�뱣���ڵ�ǰ��¼��*/

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
