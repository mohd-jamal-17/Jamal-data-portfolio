/* Set path to your folder */
%let path=/home/u64261036/Claims Data;

/* Import Claims dataset */
proc import datafile="&path./claims.csv"
    out=claims
    dbms=csv
    replace;
    guessingrows=max;
run;

/* Check first 10 rows */
proc print data=claims (obs=10); run;

