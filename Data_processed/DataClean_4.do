* Rename
rename con_clothing con_cloth
rename con_homexp con_homeexp
rename con_healthexp con_healexp
rename con_transexp con_tranexp
rename age huzhu_age
rename edu huzhu_edu
rename occu huzhu_occu
rename indu huzhu_indu
rename pop_t fam_size
rename a6_1 huzhu_gender
drop _merge

** Merge with the num_chil/ Attention
merge 1:m dcode hcode using "D:/Dissertation/Data2/02.dta"

* Generate supplimental vars
gen group=0
egen population=count(group)
gen inc_lea=inc_labor+inc_retire+inc_tran
gen con_nd=con_total-con_duraexp
gen age2=huzhu_age^2
gen saving=d961
gen invest=d964+d965+d966
**Attention
gen cpi=101.65

*adjust the price level
order huzhu_age age2 huzhu_gender huzhu_edu huzhu_indu huzhu_occu fam_size num_chil prov year group population cpi inc_lea inc_labor inc_capital inc_sale inc_tran inc_total con_nd con_food con_cloth con_homeexp con_duraexp con_healexp con_tranexp con_eduexp con_liveexp con_otherexp con_total saving invest
foreach i of var inc_lea-invest {
	gen `i'_ad=`i'*100/cpi
}

*keep the variables
keep huzhu_age age2 huzhu_gender huzhu_edu huzhu_indu huzhu_occu fam_size num_chil prov year group population cpi inc_lea_ad-invest_ad 

*generate dummies
replace huzhu_edu=(huzhu_edu==1 |huzhu_edu==2)*7+(huzhu_edu==3)*6+(huzhu_edu==4)*5+(huzhu_edu==5)*4+(huzhu_edu==6)*3+(huzhu_edu==7)*2+(huzhu_edu==8 |huzhu_edu==9)*1
drop if huzhu_edu==0
tab huzhu_edu, gen(edu)
drop edu1
drop if huzhu_occu==0
tab huzhu_occu,gen(occu)
drop occu1
drop if huzhu_indu==0
tab huzhu_indu,gen(indu)
drop indu1
replace prov=(prov==11)*1+(prov==14)*2+(prov==21)*3+(prov==23)*4+(prov==31)*5+(prov==32)*6+(prov==34)*7+(prov==36)*8+(prov==37)*9+(prov==41)*10+(prov==42)*11+(prov==44)*12+(prov==50)*13+(prov==51)*14+(prov==53)*15+(prov==62)*16
egen pop=count(year)
replace population=pop
drop pop
local a=population[1]
forvalues i=1/`a'{
	local m=prov[`i']
	local n=huzhu_edu[`i']
	quietly replace group=(prov==`m' &huzhu_edu==`n')*`m'0`n' in `i'
}
**Attention
replace year=6
save "D:\Dissertation\Data2\2002.dta", replace
