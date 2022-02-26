cd "Z:\Desktop\Github\ECON_Empirical_Projects\Labs\Lab08"
input famid str4 name inc
2 "Art" 22000
1 "Bill" 30000
3 "Paul" 25000
end
save dads, replace
clear
input famid str4 name inc
1 "Bess" 15000
3 "Pat" 50000
2 "Amy" 18000
end
save moms, replace
list
append using moms
list
gen parent “dad”
cd "Z:\Desktop\Github\ECON_Empirical_Projects\Labs\Lab08"  
save dads1,replace
gen parent= “mom”
save moms1= replace
append using dads1
clear
  input famid faminc96 faminc97 faminc98
3 75000 76000 77000
1 40000 40500 41000
2 45000 45400 45800
end
so famid
list
save faminc2
sort famid
list
save dads2.dta,replace
merge famid using faminc2
list
tab_merge
clear
input famid str4 kidname birth age wt str1 sex
1 "Beth" 1 9 60 "f"
2 "Andy" 1 8 40 "m"
3 "Pete" 1 6 20 "f"
1 "Bob" 2 6 80 "m"
1 "Barb" 3 3 50 "m"
2 "Al" 2 6 20 "f"
2 "Ann" 3 2 60 "m"
3 "Pam" 2 4 40 "f"
3 "Phil" 3 2 20 "m"
end
sort famid
save kids1.dta, replace
use dads1.dta, clear
sort famid
merge 1:m famid using kids1
list
sort famid birth
list
use  kids1.dta, clear
merge m:1 famid using dads2
sort famid birth
list
 
 
 
 

