   /*************************************/
   /* create the StatePop data set      */
   /*************************************/
data statepop;
   input State $ CityPop_80 CityPop_90 
         NonCityPop_80 NonCityPop_90 Region;
   format region 1.;
   label citypop_80=   '1980 metro pop in millions'
         noncitypop_80='1980 nonmetro pop in millions'
         citypop_90=   '1990 metro pop in millions'
         noncitypop_90='1990 nonmetro pop in millions'
         region='Geographic region';
   datalines;
ME    .405    .443   .721   .785  1   
NH    .535    .659   .386   .450  1
VT    .133    .152   .378   .411  1   
MA   5.530   5.788   .207   .229  1
RI    .886    .938   .061   .065  1   
CT   2.982   3.148   .126   .140  1
NY  16.144  16.515  1.414  1.475  1   
NJ   7.365   7.730    .A     .A   1
PA  10.067  10.083  1.798  1.799  1   
DE    .496    .553   .098   .113  2
MD   3.920   4.439   .297   .343  2   
DC    .638    .607      .     .   2
VA   3.966   4.773  1.381  1.414  2   
WV    .796    .748  1.155  1.045  2
NC   3.749   4.376  2.131  2.253  2   
SC   2.114   2.423  1.006  1.064  2
GA   3.507   4.352  1.956  2.127  2  
FL   9.039  12.023   .708   .915  2
KY   1.735   1.780  1.925  1.906  2   
TN   3.045   3.298  1.546  1.579  2
AL   2.560   2.710  1.334  1.331  2   
MS    .716    .776  1.805  1.798  2
AR    .963   1.040  1.323  1.311  2   
LA   3.125   3.160  1.082  1.060  2
OK   1.724   1.870  1.301  1.276  2   
TX  11.539  14.166  2.686  2.821  2
OH   8.791   8.826  2.007  2.021  3   
IN   3.885   3.962  1.605  1.582  3
IL   9.461   9.574  1.967  1.857  3   
MI   7.719   7.698  1.543  1.598  3
WI   3.176   3.331  1.530  1.561  3   
MN   2.674   3.011  1.402  1.364  3
IA   1.198   1.200  1.716  1.577  3   
MO   3.314   3.491  1.603  1.626  3
ND    .234    .257   .418   .381  3   
SD    .194    .221   .497   .475  3
NE    .728    .787   .842   .791  3   
KS   1.184   1.333  1.180  1.145  3
MT    .189    .191   .598   .608  4   
ID    .257    .296   .687   .711  4
WY    .141    .134   .329   .319  4   
CO   2.326   2.686   .563   .608  4
NM    .675    .842   .628   .673  4   
AZ   2.264   3.106   .453   .559  4
UT   1.128   1.336   .333   .387  4   
NV    .666   1.014   .135   .183  4
WA   3.366   4.036   .776   .830  4   
OR   1.799   1.985   .834   .858  4
CA  22.907  28.799   .760   .961  4   
AK    .174    .226   .227   .324  4
HI    .763    .836   .202   .272  4
;
run;
 


   /*************************************/
   /* close the LISTING destination     */
   /*************************************/
ods listing close;

   /*************************************/
   /* create HTML files                 */
   /*************************************/
ods html file='odshtml-body.htm'
         contents='odshtml-contents.htm'
         page='odshtml-page.htm'
         frame='odshtml-frame.htm';

   /*************************************/
   /* create procedure output in HTML   */
   /*************************************/
/*univariate 单变量的*/
proc univariate data=statepop mu0=3.5;
   var citypop_90 noncitypop_90;
   title;
run;

   /*************************************/
   /* close the HTML destination        */
   /*************************************/
ods html close;

   /*************************************/
   /* specify the data set to create    */
   /*************************************/
ods output BasicMeasures=Measures;

   /*************************************/
   /* create the Measures data set from */
   /* the BasicMeasures output object   */
   /* created by PROC UNIVARIATE        */
   /*************************************/
proc univariate data=statepop mu0=3.5;
   var citypop_90 noncitypop_90;
   title;
run;

   /*************************************/
   /* open the HTML destination for     */
   /* PROC PRINT                        */
   /*************************************/
ods html body='measures.htm';

   /*************************************/
   /* print the output data set         */
   /*************************************/
proc print data=measures noobs 
     heading=horizontal;
   title 'Output Data Set Produced from';
   title2 'PROC UNIVARIATE Basic Measures';
run;

   /*************************************/
   /* close the HTML destination        */
   /*************************************/
ods html close;

   /*************************************/
   /* open the LISTING destination      */
   /* (optional -- see notes)           */
   /*************************************/
ods listing;
 
