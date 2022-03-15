use "\\tsclient\(VMFR)Part_02\Group4_proj4_results.dta"
cd "Z:\Desktop\Github\ECON_Empirical_Projects\Empirical_Project_03\Part_02"
preserve
keep geoid kfr_pooled_p25 test training predictions_ols predictions_tree
merge 1:1 geoid using atlas_test.dta
gen pred_error = (kfr_actual- predictions_tree)^2
sum pred_error
gen pred_error1 = ( kfr_actual - predictions_ols )^2
sum pred_error1

