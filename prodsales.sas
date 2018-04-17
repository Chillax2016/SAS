*要删除每页顶部的日期;
options nodate;


data Mylib.Prdsales2;
	set Mylib.Prdsalesales;
run;
*要替换默认标题;
title "Product Sales Report";
*要删除 Obs 列并使用列标签;
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

*读取、组合和修改 SAS 数据集的主要工具是以下 4 个语句：SET、MERGE、MODIFY 和 UPDATE;

   /* exp3        */
   /*************************************/
   /* read a data set and subset        */
   /*************************************/
data canada;
   set mylib.prdsales2;
   if country='加拿大';
run;

   /*************************************/
   /* read a data set, subset,  and     */
   /* create new variables              */
   /*************************************/
data canada2;
   set mylib.prdsales2;
   if country='加拿大';
   Total_Variance=actual-predict;/* 指标C=A-B*/
   Forecast=actual*1.15;
run;
   /*************************************/
   /* read a subset using direct access */
   /*************************************/

/*下面述语句使用 POINT= 选项按数字直接访问观测，1 to 100 by 2 是从第1行到第100行，隔一行取一行，一共50行*/
/*通过从数据集 Mylib.ProductSales 中选择 50 个观测的子集来创建数据集 Product_Sample。*/

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
