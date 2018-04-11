In this lesson, you learn to

    use these main SAS windows: the Explorer, enhanced Editor (in the Windows operating environment only), Program Editor, Log, Output, and Results windows
    manage your SAS windows
    use window features, including pull-down menus, pop-up menus, toolbars, and help
    create SAS libraries
    explore and manage SAS files
    enter and submit SAS programs
    create and use file shortcuts. 
    
    
data sasuser.mysalesdata;
   set sashelp.prdsale;
   if product="SOFA";
run;

This program creates a new table, Mysalesdata (which is stored in the Sasuser library), 
by reading the Prdsale table that is stored in the Sashelp library. 
The new table contains only rows in which the value of the column Product is SOFA.
    
