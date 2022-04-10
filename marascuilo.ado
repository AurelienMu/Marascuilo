*! version 1.1  09apr2022
cap prog drop marascuilo
program define marascuilo
	version 10.0
	syntax varlist(min=2 max=2)  [if] [in] 
	marksample touse, novar
	tokenize `varlist'
	
	tempname val1 val2
	
	cap drop binary_var /*** Drop variable binary_var ****/
	capture confirm numeric variable  `1' /*** Check if var1 is numeric ***/
	if _rc != 0 { /** in not numeric, encode binary_var **/		
		encode `1' , gen(binary_var)
		label variable binary_var "`1'"  /** binary_var take the var1 name as label **/
	}
	else {
		clonevar binary_var = `1' /*** Else clone var1 into binary_var ****/
	}
	quietly {
		summarize binary_var if `touse' 	
		if r(N) == 0 { 
			noisily error 2000 
			}
		scalar `val1' = r(min)
		scalar `val2' = r(max)

			/* Check that there are exactly 2 groups. */

			if `val1' == `val2' {
				di in red "1 group found, 2 required"
				exit 420
			}

			count if binary_var!=`val1' & binary_var!=`val2' & binary_var!=. & `touse'
			if r(N) != 0 {
				di in red "more than 2 groups found, only 2 allowed"
				exit 420
			}
	
	/* Get group labels of var1 (binary_var) */

		local lab1 = `val1'
		local lab2 = `val2'	
		
		local bylab : value label binary_var

		if "`bylab'"!="" {
			local lab1 : label `bylab' `lab1'
			if `"`lab1'"'=="" {
				local lab1 = `val1'
			}
			local lab2 : label `bylab' `lab2'
			if `"`lab2'"'=="" {
				local lab2 = `val2'
			}
		}
		local lab1 = usubstr(`"`lab1'"',1,8)
		local lab2 = usubstr(`"`lab2'"',1,8)
		
	}
	
	

	cap drop marasc_groups /*** Drop variable marasc_groups if it exists ****/
	capture confirm numeric variable  `2' /*** Check if var2 is numeric ***/
	if _rc != 0 { /** in not numeric, encode **/		
		encode `2' , gen(marasc_groups)
	}
	else {
		clonevar marasc_groups = `2' /*** Else clone var2 into marasc_groups ****/
	}
	

	/**** display table *****/
	ta binary_var marasc_groups  if `touse', nokey   matcell(effectifs) col matcol(col_names)
	
	/*** retrieve values for computations ****/
	mata : st_matrix("coltot", colsum(st_matrix("effectifs")))
	mata : st_matrix("rowtot", rowsum(st_matrix("effectifs")))
	local ncol = `=colsof(effectifs)'     /**** get columns number *******/
	forvalues k=1(1)`ncol' {       
		local pct`k' = effectifs[2, `k'] / coltot[1, `k']       /*** compute percentages ****/
	}
	/*** Marascuilo procedure ****/
	di "Marascuilo Procedure : "
	qui levelsof marasc_groups, local(marasc_groups_levels)
	local var2lab: value label marasc_groups /*** var2 labels ****/
	
	forvalues i=1(1)`ncol' {
		local gp_num_i : word `i' of `marasc_groups_levels'
		if "`var2lab'" != "" {       /*** Chekcs if var2 has labels ***/
			local gp`i' : label `var2lab' `gp_num_i'     /*** if true get labels ****/
			}
		else {
			local gp`i' = `gp_num_i'      /*** if false, get values ***/
		}
		forvalues j=`=`i'+1'(1)`=`ncol-1'' {
			local gp_num_j : word `j' of `marasc_groups_levels'
			if "`var2lab'" != "" {      /*** Chekcs if var2 has labels ***/
				local gp`j' : label `var2lab' `gp_num_j'    /*** if true get labels ****/
			}
			else {
				local gp`j' = `gp_num_j'    /*** if false, get values ***/
			}
			local diff`i'`j' = abs(`pct`i'' - `pct`j'') /***  computate differences ***/
			local r`i'`j' = sqrt(invchi2(`ncol'-1 ,0.95)) * sqrt(`pct`i''*(1-`pct`i'')/coltot[1, `i'] + `pct`j''*(1-`pct`j'')/coltot[1, `j'])   /*** compute critical range  ****/
			/*** display 2 by 2 groups comparison according to significance ***/
			if `r`i'`j'' < `diff`i'`j'' { 
				display "Difference between `gp`i'' and `gp`j'' (`:display %3.1f `=round(`pct`i'',0.001)*100''% vs `: display %3.1f `=round(`pct`j'',0.001)*100''% of `lab2') is significant (delta = `: display %3.1f `=round(`diff`i'`j'',0.001)*100'' > critical range = `: display %4.1f `=round(`r`i'`j'',0.001)*100'')" 
			}
			else {
				display "Difference between `gp`i'' and `gp`j'' (`:display %3.1f `=round(`pct`i'',0.001)*100''% vs `: display %3.1f `=round(`pct`j'',0.001)*100''% of `lab2') is not significant (delta = `: display %3.1f `=round(`diff`i'`j'',0.001)*100'' < critical range = `: display %4.1f `=round(`r`i'`j'',0.001)*100'')"
			}
		}
	}
	
	drop marasc_groups	 binary_var
end
