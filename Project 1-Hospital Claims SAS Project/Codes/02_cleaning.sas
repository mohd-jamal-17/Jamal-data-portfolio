data claims_clean;
    set claims;

    /* Standardize claim amount */
    if claim_amount < 0 then claim_amount = .;  /* remove negative claims */

    /* Robust Claim Date parsing */
    length Claim_Date_sas 8;
    format Claim_Date_sas date9.;

    if vtype(CLAIM_DATE) = 'C' then do;
        _tmp = strip(CLAIM_DATE);
        if _tmp ne '' then Claim_Date_sas = input(_tmp, anydtdte.);
        else Claim_Date_sas = .;
        drop _tmp;
    end;
    else if vtype(CLAIM_DATE) = 'N' then do;
        if not missing(CLAIM_DATE) and CLAIM_DATE >= 100000 then
            Claim_Date_sas = input(put(CLAIM_DATE,8.), yymmdd8.);
        else if not missing(CLAIM_DATE) then
            Claim_Date_sas = CLAIM_DATE;  /* already a SAS date */
        else Claim_Date_sas = .;
    end;

    /* Derive Claim_Month */
    if not missing(Claim_Date_sas) then Claim_Month = month(Claim_Date_sas);

run;

/* Remove duplicate Claim_IDs */
proc sort data=claims_clean nodupkey;
    by claim_id;
run;