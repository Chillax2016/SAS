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

/*�ڶ�����ֵ������¶��������б��� (FastGlucose) ��ֵ�����䶨��Ϊ�߳� 10%��
��һ��������ͬʱ�����ڵȺ�����ʱ���Ҷ˵�ԭʼֵ��������ʽ��ֵ������������Ⱥ���˵ı�����
�������ĵ�һ�γ������ڸ�ֵ�����Ҷˣ�SAS ��ٶ�����һ����ֵ�ͱ�������ֵȱʧ��
���������������丳ֵ���� SAS ����־�д�ӡһ��ע�ͣ�˵���ñ���δ����ʼ����*/

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
/*ʹ�� ATTRIB ��䣬����Ϊ���б���ָ������һ�������������ԣ�
?FORMAT= 
?INFORMAT= 
?LABEL= 
?LENGTH= 

�������в����ڣ������ FORMAT=��INFORMAT= �� LENGTH= �е�һ�����������������±�����
�˴��� ATTRIB ��䴴���˱��� Sale_Price����Ϊ��ָ���������ʽ�ͱ�ǩ��
FORMAT ���֮��ĸ�ֵ���Ϊ Sale_Price ָ����ֵ��
*/

data sales;   
attrib Sale_Price format=6.2 
          label="Sale Price";
   Sale_Price=49.99;
run;
