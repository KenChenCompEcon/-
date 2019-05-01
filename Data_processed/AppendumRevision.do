drop _merge
merge m:1 year using "D:\Dissertation\Data2\Theil.dta"
gsort +year +group
drop if theil==.
egen pop=count(year)
gen yinc=0
local a=pop[1]
replace yinc=inc_lea_ad[1] in 1
forvalues i=2/`a' {
	if year[`i']==year[`i'-1] {
		quietly replace yinc=yinc[`i'-1]+inc_lea_ad[`i'] in `i'
	}
	else {
		quietly replace yinc=inc_lea_ad[`i'] in `i'
	}
}
local b=pop[1]-1
forvalues i=`b'(-1)1{
	if year[`i']==year[`i'+1] {
		quietly replace yinc=yinc[`i'+1] in `i'
	} 
}
gen theil_dis=theil*inc_lea_ad/yinc
gen theil_w=0
local a=pop[1]
replace theil_w=theil_dis[1] in 1
forvalues i=2/`a' {
	if year[`i']==year[`i'-1] {
		quietly replace theil_w=theil_w[`i'-1]+theil_dis[`i'] in `i'
	}
	else {
		quietly replace theil_w=theil_dis[`i'] in `i'
	}
}
local b=pop[1]-1
forvalues i=`b'(-1)1{
	if year[`i']==year[`i'+1] {
		quietly replace theil_w=theil_w[`i'+1] in `i'
	} 
}
gen theil_b=theil_t-theil_w
gen llea=log(inc_lea_ad)
gen lnd=log(con_nd)
