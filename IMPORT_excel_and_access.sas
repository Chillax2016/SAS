   /*************************************/
   /* import the Excel file             */
   /*************************************/
proc import datafile="c:\myfiles\Accounts.xls"
     out=sasuser.accounts;
     sheet="Prices";
     getnames=no;
run;
 
   /*************************************/
   /* print part of the new data set    */
   /*************************************/
proc print data=sasuser.accounts(obs=10);
run;

   /*************************************/
   /* import the Access file            */
   /*************************************/
proc import table="customers"
     out=sasuser.cust dbms=access;
   uid="userid";
   pwd="mypassword";
   database="c:\myfiles\east.mdb";
   wgdb="c:\winnt\system32\security.mdb";
run;
   /*************************************/
   /* print part of the new data set    */
   /*************************************/
proc print data=sasuser.cust(obs=5);
run;
