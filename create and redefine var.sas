   /*all these data are save on a temporary lib "Work"*/
   /*************************************/
   /* create variables with INPUT       */
   /*************************************/
data diabetes;
   input ID $ Sex $ Age Height Weight 
         Pulse FastGlucose PostGlucose;
   datalines;
2304 F 16 61 102 100 568 625
1128 M 43 71 218  76 156 208
4425 F 48 66 162  80 244 322
1387 F 57 64 142  70 177 206
9012 F 39 63 157  68 257 318
6312 M 52 72 240  77 362 413
5438 F 42 62 168  83 247 304
3788 M 38 73 234  71 486 544
9125 F 56 64 159  70 166 215
3438 M 15 66 140  67 492 547
1274 F 50 65 153  70 193 271
3347 M 53 70 193  78 271 313
2486 F 63 65 157  70 152 224
1129 F 48 61 137  69 267 319
9723 M 52 75 219  65 348 403
8653 M 49 68 185  79 259 311
4451 M 54 71 196  81 373 431
3279 M 40 70 213  82 447 504
4759 F 60 68 164  71 155 215
6488 F 59 64 154  75 362 409
;
run;

   /*************************************/
   /* create and redefine variables     */
   /* with assignment, function         */
   /*************************************/

/*第二个赋值语句重新定义了现有变量 (FastGlucose) 的值，将其定义为高出 10%。
当一个变量名同时出现在等号两侧时，右端的原始值用于求表达式的值。结果即赋给等号左端的变量。
若变量的第一次出现是在赋值语句的右端，SAS 则假定这是一个数值型变量且其值缺失。
若后面再无语句对其赋值，则 SAS 在日志中打印一条注释，说明该变量未被初始化。*/

data diabetes_female;   
set diabetes;   
if sex='F';   
GlucoseChange=postglucose-fastglucose;   
fastglucose=fastglucose+fastglucose*.10;   
AvgGlucose=mean(postglucose,fastglucose);
run;  

   /*************************************/
   /* create variables with LENGTH      */
   /*************************************/
data PatientAccounts;   
set diabetes(keep=id sex age);   
length Group $ 8;   
if age>=55 then group='Seniors';   
else group='Under 55';
run;

   /*************************************/
   /* create variable with FORMAT       */
   /*************************************/
data sales;   
format Sale_Price 6.2;
   Sale_Price=49.99;
run;   

   /*************************************/
   /* create variables with ATTRIB      */
   /*************************************/
/*使用 ATTRIB 语句，您可为现有变量指定以下一个或多个变量属性：
?FORMAT= 
?INFORMAT= 
?LABEL= 
?LENGTH= 

若变量尚不存在，则可用 FORMAT=、INFORMAT= 或 LENGTH= 中的一个或多个属性来创建新变量。
此处的 ATTRIB 语句创建了变量 Sale_Price，并为其指定了输出格式和标签。
FORMAT 语句之后的赋值语句为 Sale_Price 指定了值。
*/

data sales;   
attrib Sale_Price format=6.2 
          label="Sale Price";
   Sale_Price=49.99;
run;
