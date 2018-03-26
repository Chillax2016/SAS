
下面的语句中有一个data 三个proc

data work.profit;
   infile sales;
   input Year 1-4 Expenses 6-10          
         Revenue 12-16;
run;
proc means data=work.profit;
run;
proc print data=work.profit;
run;
proc sort data=work.profit;
   by year;
run;


How many individual SAS statements does this program contain?  6
一个分号就是一个独立的sas语句

data supply;
   infile tv;
   input Brand $ 1-8 Model $ 9-14
         Color $ 15-20 Stock 21-23          
         Ordered 24-26 Sold 27-29;
run;
proc print data=supply;
run;

How many program steps are executed during the processing of the program below? 2
proc tabulate data=clinic.insure;
   class company;
   var total balance;
   table company all, mean*total          
         max*balance;
run;
proc print data=clinic.insure;
run;

