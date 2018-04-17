PROC IMPORT OUT= MYLIB.WatsonsOrderData 
            DATAFILE= "E:\¹¤×÷\Çü³¼ÊÏ\order-20170301.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="'order-20170301$'"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
