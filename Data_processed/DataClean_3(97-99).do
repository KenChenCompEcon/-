*Generate supplemental vars
egen pop=count(x1)
gen num_chil=(x6>=1& x6<16)+(x43>=1& x43<16)+(x80>=1& x80<16)+(x117>=1& x117<16)+(x154>=1& x154<16)+(x191>=1& x191<16)+(x228>=1& x228<16)
**Attention
replace x1=x1-9700000
gen provce=(x1>=10000& x1<=10499)*11+((x1>=12300& x1<=13199)|(x1>=50500& x1<=50649))*21+((x1>=15600& x1<=15999)|(x1>=51250& x1<=51399))*33+((x1>=19100& x1<=19599)|(x1>=52600& x1<=52699))*44+((x1>=20200& x1<=20999)|(x1>=52900& x1<=53199))*51+((x1>=21900& x1<=22199)|(x1>=53500& x1<=53699))*61
gen group=0
gen inc_lea=inc_labor+inc_retire+inc_tran+inc_total
gen con_nd=con_total-con_duraexp
gen saving=x465
gen invest=x469+x470
gen age2=huzhu_age^2
rename x5 huzhu_gender
replace huzhu_occu=int(x10/10)
**Attention
gen cpi=100
gen year=1997

*adjust the price level
order huzhu_age age2 huzhu_gender huzhu_edu huzhu_indu huzhu_occu pop_t num_chil provce year group pop cpi inc_lea inc_labor inc_capital inc_sale inc_tran inc_total con_nd con_food con_cloth con_homeexp con_duraexp con_healexp con_tranexp con_eduexp con_liveexp con_otherexp con_total saving invest
foreach i of var inc_lea-invest {
	gen `i'_ad=`i'*100/cpi
}

*keep the variables
keep huzhu_age age2 huzhu_gender huzhu_edu huzhu_indu huzhu_occu pop_t num_chil provce year group pop cpi inc_lea_ad-invest_ad 
rename pop population
rename pop_t fam_size
rename provce prov

*generate dummies
drop if huzhu_edu==0
tab huzhu_edu, gen(edu)
drop edu1
drop if huzhu_occu==0
tab huzhu_occu,gen(occu)
drop occu1
drop if huzhu_indu==0
tab huzhu_indu,gen(indu)
drop indu1
replace prov=(prov==11)*1+(prov==14)*2+(prov==21)*3+(prov==23)*4+(prov==31)*5+(prov==32)*6+(prov==34)*7+(prov==36)*8+(prov==37)*9+(prov==41)*10+(prov==42)*11+(prov==44)*12+(prov==50)*13+(prov==51)*14+(prov==53)*15+(prov==62)*16+(prov==33)*17+(prov==61)*18
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
replace year=1
save "D:\Dissertation\Data2\1997.dta", replace











