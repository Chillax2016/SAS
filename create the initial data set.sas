   /*************************************/
   /* create the initial data set       */
   /*************************************/
data admit;
   input ID $ 1-4 Name $ 6-19 Sex $ 21 Age 23-24
         Date 26-27 Height 29-30 Weight 32-34
         ActLevel $ 36-39 Fee 41-46;
   format fee 6.2;
   datalines;
2458 Murray, W      M 27  1 72 168 HIGH  85.20
2462 Almers, C      F 34  3 66 152 HIGH 124.80
2501 Bonaventure, T F 31 17 61 123 LOW  149.75
2523 Johnson, R     F 43 31 63 137 MOD  149.75
2539 LaMance, K     M 51  4 71 158 LOW  124.80
2544 Jones, M       M 29  6 76 193 HIGH 124.80
2552 Reberson, P    F 32  9 67 151 MOD  149.75
2555 King, E        M 35 13 70 173 MOD  149.75
2563 Pitts, D       M 34 22 73 154 LOW  124.80
2568 Eberhardt, S   F 49 27 64 172 LOW  124.80
2571 Nunnelly, A    F 44 19 66 140 HIGH 149.75
2572 Oberon, M      F 28 17 62 118 LOW   85.20
2574 Peterson, V    M 30  6 69 147 MOD  149.75
2575 Quigley, M     F 40  8 69 163 HIGH 124.80
2578 Cameron, L     M 47  5 72 173 MOD  124.80
2579 Underwood, K   M 60 22 71 191 LOW  149.75
2584 Takahashi, Y   F 43 29 65 123 MOD  124.80
2586 Derber, B      M 25 23 75 188 HIGH  85.20
2588 Ivan, H        F 22 20 63 139 LOW   85.20
2589 Wilcox, E      F 41 16 67 141 HIGH 149.75
2595 Warren, C      M 54  7 71 183 MOD  149.75
;
run;

   /*************************************/
   /* select observations and variables */
   /*************************************/
data subset1;
   set admit;
   if fee>= 124.80 & sex = 'M';
   keep id name age weight;
run;
   /*************************************/
   /* subset data, perform processing,  */
   /* and subset variables again        */
   /*************************************/
data subset2(keep=id sex kgweight);
   set admit(drop=name date);
   if actlevel='LOW' and age>40;
   KgWeight=weight/2.2;
run;
