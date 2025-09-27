/* Validation checks */
proc freq data=claims nlevels;
    tables claim_id patient_id / noprint;
run;

/* Missing required fields */
proc freq data=claims;
    tables (claim_id patient_id claim_amount claim_date) / missing;
run;

/* Negative or zero claim amount */
proc print data=claims;
    where claim_amount <= 0 or claim_amount is missing;
    title "Zero/Negative or Missing CLAIM_AMOUNT";
run;

/* Duplicate Claim_IDs */
proc sort data=claims out=_sort nodupkey dupout=dups;
    by claim_id;
run;

proc print data=dups (obs=50);
    title "Duplicate Claim_ID rows (if any)";
run;
