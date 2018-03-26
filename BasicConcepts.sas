


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







