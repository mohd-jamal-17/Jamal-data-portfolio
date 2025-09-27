title "Claim Status Summary";
proc freq data=claims_clean;
    tables status;
run;

title "Claim Amount by Hospital";
proc means data=claims_clean mean sum maxdec=2;
    class hospital;
    var claim_amount;
run;

title "Monthly Claim Trend";
proc means data=claims_clean sum;
    class Claim_Month;
    var claim_amount;
run;
