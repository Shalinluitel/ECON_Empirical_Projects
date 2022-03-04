use "\\tsclient\(VMFR)Empirical_Project_03\atlas_training.dta"
cd "\\tsclient\shalinluitel\Desktop\Github\ECON_Empirical_Projects\Empirical_Project_03"
import delimited "datacommons_data.csv", clear
br
sum
drop dcx6l3mg60hpe7c
br
gen geoid1 = substr(placedcid,7,11)
destring geoid1, gen(geoid)
drop placedid geoid1
ds geoid place, not
local vars = r(varlist)
merge 1:1 geoid using atlas_training
sum
replace count_person_enrolledincollegeun = count_person_enrolledincollegeun/pop
replace count_person_enrolledinschool = count_person_enrolledinschool/pop
replace unemploymentrate_person = unemploymentrate_person/100
replace median_income_household = median_income_household/ housing
replace count_housingunit = count_housingunit/ housing
replace median_income_person = median_income_person/pop
replace count_household_05orlessratiotop = count_household_05orlessratiotop/ housing
replace count_household_nohealthinsuranc = count_household_nohealthinsuranc / housing

sum kfr_pooled_p25 rate_black_population_2010 count_person_enrolledincollegeun count_person_enrolledinschool unemploymentrate_person median_income_household count_housingunit genderincomeinequality_person_15 median_income_person count_household_05orlessratiotop count_household_nohealthinsuranc

global predictorvars "rate_black_population_2010 count_person_enrolledincollegeun count_person_enrolledinschool unemploymentrate_person median_income_household count_housingunit genderincomeinequality_person_15 median_income_person count_household_05orlessratiotop count_household_nohealthinsuranc"

reg kfr_pooled_p25 $predictorvars P_* if training == 1, r
predict rank_hat_ols
order geoid place pop housing kfr_pooled_p25 test training _merge rank_hat_ols
save "Z:\Desktop\Github\ECON_Empirical_Projects\Empirical_Project_03\GROUP_No_4_project3.dta"
