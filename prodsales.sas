*Ҫɾ��ÿҳ����������;
options nodate;


data Mylib.Prdsales2;
	set Mylib.Prdsalesales;
run;
*Ҫ�滻Ĭ�ϱ���;
title "Product Sales Report";
*Ҫɾ�� Obs �в�ʹ���б�ǩ;
proc print data =  Mylib.Prdsales2 label noobs;
run;



/* exp1 */
 /*************************************/
   /* define SAS library                */
   /*************************************/
libname sales 'E:\SAS'; 
   /*************************************/
   /* create new data set from raw data */
   /*************************************/
data sales.quarter1;
   length Department $ 7 Site $ 8;
   input Department Site Quarter Sales;
   datalines;
Parts   Sydney  1 4043.97
Parts   Atlanta 1 6225.26
Parts   Paris   1 3543.97
Repairs Sydney  1 5592.82
Repairs Atlanta 1 9210.21
Repairs Paris   1 8591.98
Tools   Sydney  1 1775.74
Tools   Atlanta 1 2424.19
Tools   Paris   1 5914.25
;
run;
   /*************************************/
   /* print new data set                */
   /*************************************/
proc print data=sales.quarter1;
run;

   /*************************************/
   /* print existing data set           */
   /*************************************/
proc print data=mylib.prdsalesales;
run;


/* exp2 */
/*************************************/
   /* define SAS library for Oracle     */
   /*************************************/
libname myorlib oracle user=scott password=tiger 
        path="blunzer:v7" schema=hrdept;
   /*************************************/
   /* define SAS library for DB2        */
   /*************************************/
libname mydblib db2 
        noprompt="user=testuser;
        password=testpass;database=testdb";
  /*************************************/
   /* print Oracle table                */
   /*************************************/
proc print data=myorlib.all_employees;
   where state='CA';
run;

   /*************************************/
   /* print DB2 table                   */
   /*************************************/
proc print data=mydblib.customers;
   where state='CA';
run;

   /*************************************/
   /* clear librefs                     */
   /*************************************/
libname myorlib clear;
libname mydblib clear;

*��ȡ����Ϻ��޸� SAS ���ݼ�����Ҫ���������� 4 ����䣺SET��MERGE��MODIFY �� UPDATE;

   /* exp3        */
   /*************************************/
   /* read a data set and subset        */
   /*************************************/
data canada;
   set mylib.prdsales2;
   if country='���ô�';
run;

   /*************************************/
   /* read a data set, subset,  and     */
   /* create new variables              */
   /*************************************/
data canada2;
   set mylib.prdsales2;
   if country='���ô�';
   Total_Variance=actual-predict;/* ָ��C=A-B*/
   Forecast=actual*1.15;
run;
   /*************************************/
   /* read a subset using direct access */
   /*************************************/

/*���������ʹ�� POINT= ѡ�����ֱ�ӷ��ʹ۲⣬1 to 100 by 2 �Ǵӵ�1�е���100�У���һ��ȡһ�У�һ��50��*/
/*ͨ�������ݼ� Mylib.ProductSales ��ѡ�� 50 ���۲���Ӽ����������ݼ� Product_Sample��*/

data product_sample;
   do obsnum=1 to 100 by 2;
      set mylib.prdsales2 point=obsnum;
      if _error_ then abort;
      output;
   end;
   stop;
run;

proc print data= canada;
run;
proc print data= canada2;
run;
proc print data= product_sample;
run;
