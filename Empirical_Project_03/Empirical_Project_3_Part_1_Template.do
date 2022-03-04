*Template for Empirical Project 3 - Part 1

clear all

cd //insert the path for where your Downloaded Data Commons csv file is 
*Example: cd "C:\Users\Aseni Ariyaratne\Dropbox\Drexel_Econ270\Projects\Project 4"

import delimited //insert name of csv file
*Example: import delimited "datacommons_cdc_deaths.csv", clear 

*Get rid of county prefix on variables

*Summarize data

*Drop data with lots of missing values

*We have to create the variable geoid which will be the common variable when merging data
gen geoid1 = substr(placedcid,7,11)
destring geoid1, gen(geoid)
drop placedcid geoid1

*Store all the remaining predictors
*Here place should be the variable which describes the county. Rename as needed to continue. 
ds geoid place, not
local vars = r(varlist)

*Merge with atlas training data using geoid
merge 1:1 //fill in the rest 

*Turn into a rate (deaths per 100,000)

*METHOD 1
*Since the data in atlas training is already in rates, you only need to convert the variables you downloaded - the ones you didn't drop
*Follow Table 2


*METHOD 2 (More advanced Stata code) 
*Impute 0 for missing -1 and .'s from CDC wonder
foreach j in `vars' {
replace `j' = 0 if `j' == -1 | missing(`j')
replace `j' = 100000*`j' / pop

}


*Produce summary statistics for combined data

*Store predictors
*Example: global predictorvars "v6 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17"
*use the names of the variables you downloaded instead of v6, v8, v9 etc.

*OLS regression
reg kfr_pooled_p25 $predictorvars P_* if training == 1, r
predict rank_hat_ols
*for the simple example: y_hat = a_hat + b_hat*x; line 54 gives you y_hat 
*So you can generate squared error (y - y_hat)^2 and sum gives you the mean squared error. This is for Q8 - Refer Table 2!


*Now prep data for exporting to R for decision trees and random forests

*Reorder variables
order geoid place pop housing kfr_pooled_p25 test training _merge rank_hat_ols

*Save data file
save GROUP_NO_project4.dta, replace
*Please make sure you save the file using your respective group number