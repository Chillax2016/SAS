data a1;
input wt ht;
bmi = wt/(ht/100)**2;
rbmi = sqrt(bmi);
obesity = (bmi >=28);
city = "Beijing";
date = "02apr2013"d;
format date yymmdd10.;
cards;
60 170
55 166
73 161
45 162
;

proc print;
run;
