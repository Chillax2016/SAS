
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

生成sex与ActLevel(height weight)交叉的表
proc tabulate data=clinic.admit;
        class sex;
        var height weight;
        table sex*(height weight),mean;
     run;

a log that contains messages about the program is always produced when a SAS program executes.

A SAS library is a collection of SAS files and other software files.

The library name WORK specifies that files be stored temporarily in the library it references. 

Any library name other than the default Work indicates that the files in a SAS data library are stored permanently. （Perm/Stress）

Two-Level Names：（libref.filename）
In the two-level name, libref is the name of the SAS data library that contains the file, and filename is the name of the file itself. A period separates the libref and filename. 
Clinic.Admit （Clinic：library name；；Admit： filename）



























