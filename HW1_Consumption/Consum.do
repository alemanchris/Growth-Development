* Student: Christian Aleman
* Subject: Growth and Development
* The following code, solves Homework 1
****************************************************************************************************
* The following code, uses the "" to make an estimate of yearly consumption 
* of the population of Burkina Faso in 2014
* To run the code, just change the respective load paths. The code is commented enough.
*************************************************************************************************
* Deflactors used
* March 106.6
* Juin 108.6
* Sept 108.1
* Dec 107.1
**************
* First Wave *
**************
**************
* Total Consumption-Nominal 

* Food Consumption_convert to three months

use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p1_conso7jours_16032015.dta", clear
drop if hhid==159009 | hhid==689005
gen  autocons_0=0
replace autocons_0=autocons if autocons!=.
gen  cadeau_0=0
replace cadeau_0=cadeau if cadeau!=.
drop cadeau
gen cadeau=(cadeau_0+autocons_0)*4*3
drop cadeau_0
replace achat=achat*4*3
order achat cadeau hhid hhsize1 hhweight1 region milieu product
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w1_7.dta",replace

* Non Food Consumption convert to anual
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p1_conso3mois_16032015.dta", clear
drop if mi(hhid)
drop if hhid==159009 | hhid==689005
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
order achat cadeau hhid hhsize1 hhweight1 region milieu product
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w1_7.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
do "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\paralel.do"

* Create unique household rows
duplicates drop hhid, force
* Deflate
replace tot_cons2=tot_cons2*100/106.6
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w1_total.dta",replace

* Correct for seasonality
egen der_min=min(tot_cons2)
gen tot_cons2ses=tot_cons2-der_min
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w1_total_season.dta",replace

***************
* Second Wave *
***************

* 7 jour ALimentaires
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p2_conso7jours_16032015.dta", clear
gen  autocons_0=0
replace autocons_0=autocons if autocons!=.
gen  cadeau_0=0
replace cadeau_0=cadeau if cadeau!=.
drop cadeau
gen cadeau=(cadeau_0+autocons_0)*4*3
drop cadeau_0
replace achat=achat*4*3
rename hhsize2 hhsize1
rename hhweight2 hhweight1
order achat cadeau hhid hhsize1 hhweight1 region milieu product

save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_7alim.dta",replace

* 7 jour non-Alim
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p2_conso7nonalimjours_17032015.dta", clear
rename hhsize2 hhsize1
rename hhweight2 hhweight1
order achat cadeau hhid hhsize1 hhweight1 region milieu product
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_7noalim.dta",replace

* 3 Months
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p2_conso3mois_16032015.dta", clear
rename hhsize2 hhsize1
rename hhweight2 hhweight1
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
order achat cadeau hhid hhsize1 hhweight1 region milieu product
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_7alim.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_7noalim.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
do "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\paralel.do"

* Create unique household rows
duplicates drop hhid, force
* Deflate
replace tot_cons2=tot_cons2*100/108.6
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_total.dta",replace

* Correct for seasonality
egen der_min=min(tot_cons2)
gen tot_cons2ses=tot_cons2-der_min
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_total_season.dta",replace


***************
* Third Wave  *
***************
* 7 jour
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p3_conso7jours_16032015.dta", clear
gen  autocons_0=0
replace autocons_0=autocons if autocons!=.
gen  cadeau_0=0
replace cadeau_0=cadeau if cadeau!=.
drop cadeau
gen cadeau=(cadeau_0+autocons_0)*4*3
drop cadeau_0
replace achat=achat*4*3
rename hhsize3 hhsize1
rename hhweight3 hhweight1
order achat cadeau hhid hhsize1 hhweight1 region milieu product

save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_7alim.dta",replace

* 7 jour-noalim
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p3_conso7nonalimjours_16032015.dta", clear
rename hhsize3 hhsize1
rename hhweight3 hhweight1
order achat cadeau hhid hhsize1 hhweight1 region milieu product
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_7noalim.dta",replace

* 3 month
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p3_conso3mois_16032015.dta", clear
rename hhsize3 hhsize1
rename hhweight3 hhweight1
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
order achat cadeau hhid hhsize1 hhweight1 region milieu product
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_7alim.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_7noalim.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
do "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\paralel.do"

* Create unique household rows
duplicates drop hhid, force
* Deflate
replace tot_cons2=tot_cons2*100/108.1
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_total.dta",replace

* Correct for seasonality
egen der_min=min(tot_cons2)
gen tot_cons2ses=tot_cons2-der_min
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_total_season.dta",replace

****************
* Fourth Wave  *
****************
* 7 jours
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p4_conso7jours_10032015.dta", clear
gen  autocons_0=0
replace autocons_0=autocons if autocons!=.
gen  cadeau_0=0
replace cadeau_0=cadeau if cadeau!=.
drop cadeau
gen cadeau=(cadeau_0+autocons_0)*4*3
drop cadeau_0
replace achat=achat*4*3
rename hhsize4 hhsize1
rename hhweight4 hhweight1
order achat cadeau hhid hhsize1 hhweight1 region milieu product
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_7alim.dta",replace

* 7 jours noalim
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p4_conso7nonalimjours_10032015.dta", clear
rename hhsize4 hhsize1
rename hhweight4 hhweight1
order achat cadeau hhid hhsize1 hhweight1 region milieu product
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_7noalim.dta",replace

* 3 months
use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\emc2014_p4_conso3mois_10032015.dta", clear
rename hhsize4 hhsize1
rename hhweight4 hhweight1
keep achat cadeau hhid hhsize1 hhweight1 region milieu product
order achat cadeau hhid hhsize1 hhweight1 region milieu product
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_7alim.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_7noalim.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product)
do "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\paralel.do"

* Create unique household rows
duplicates drop hhid, force
* Deflate
replace tot_cons2=tot_cons2*100/107.1
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_total.dta",replace

* Correct for seasonality
egen der_min=min(tot_cons2)
gen tot_cons2ses=tot_cons2-der_min
save "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_total_season.dta",replace


**********
* Append *
**********


use "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w4_total_season.dta",clear
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w3_total_season.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product tot_cons2 tot_cons2ses)
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w2_total_season.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product tot_cons2 tot_cons2ses)
append using "C:\Users\Aleman\Documents\Mydocs 2\Master QEM\QEM year2\Segundo Semestre\Llopis\Burquina Faso\BKA_2013_EMC_v01_M_STATA8\append\w1_total_season.dta", keep(achat cadeau hhid hhsize1 hhweight1 region milieu product tot_cons2 tot_cons2ses)
gen new_id=_n
drop hhid

***************
* No seasonal *
***************

* Test Histograms
* 1 Urban
* 2 Rural

local k = 4 
/* Match sampling weights to k = 2 decimal places:
   e.g. sampling weight = 3.212 -> fwt =321 */ 
gen fwt = round(10^(`k')*hhweight1,1)
gen lcons= log(tot_cons2)              //Careful with the zeros

* Summary statistics
summ lcons [fweight=fwt],detail
by milieu, sort: summ lcons [fweight=fwt] ,detail

* Normalize
egen mean_consum=mean(tot_cons2)
replace lcons=log(tot_cons2/mean_consum)

twoway (histogram lcons if milieu==1 [fweight=fwt] ,width(0.1) lcolor(red) lw(vthin) fcolor(none) fintensity(inten10) disc den)(histogram lcons if milieu==2 [fweight=fwt],width(0.1) lcolor(blue) lw(vvthin) fcolor(none) fintensity(inten10) disc den),legend(order(1 "Urban" 2 "Rural")) xtitle("Normalized log consumption")
twoway (histogram lcons if milieu==1 [fweight=fwt] ,width(0.1) lcolor(red) lw(vthin) fcolor(none) fintensity(inten10) disc den)(histogram lcons if milieu==2 [fweight=fwt],width(0.1) lcolor(blue) lw(vvthin) fcolor(none) fintensity(inten10) disc den) if lcons>=-3.5 & lcons<=3.5,legend(order(1 "Urban" 2 "Rural")) xtitle("Normalized log consumption- Trimmed")


* Calculating the gini, method 1
ineqdeco tot_cons2
ineqdeco tot_cons2, by(milieu)
* Calculating the marginal distributions and the gini, method2

pshare tot_cons2 [pweight=hhweight1], percent p(1 5 10 90 95 99) gini
pshare tot_cons2 if milieu==1 [pweight=hhweight1], percent p(1 5 10 90 95 99) gini
pshare tot_cons2 if milieu==2 [pweight=hhweight1], percent p(1 5 10 90 95 99) gini



pshare tot_cons2 [pweight=hhweight1], percent n(5) gini
pshare tot_cons2 if milieu==1 [pweight=hhweight1], percent n(5) gini
pshare tot_cons2 if milieu==2 [pweight=hhweight1], percent n(5) gini


************
* Seasonal *
************
 gen lcons_ses= log(tot_cons2ses)              //Careful with the zeros
 
 * Summary statistics
summ lcons_ses [fweight=fwt],detail
by milieu, sort: summ lcons [fweight=fwt] ,detail

* Normalize

egen mean_consumses=mean(tot_cons2ses)
replace lcons_ses=log(tot_cons2ses/mean_consumses) 
* Histograms
twoway (histogram lcons_ses if milieu==1 [fweight=fwt] ,width(0.1) lcolor(red) lw(vthin) fcolor(none) fintensity(inten10) disc den)(histogram lcons_ses if milieu==2 [fweight=fwt],width(0.1) lcolor(blue) lw(vvthin) fcolor(none) fintensity(inten10) disc den) if lcons_ses>=-6,legend(order(1 "Urban" 2 "Rural")) xtitle("Normalized log consumption-adjust")
twoway (histogram lcons_ses if milieu==1 [fweight=fwt] ,width(0.1) lcolor(red) lw(vthin) fcolor(none) fintensity(inten10) disc den)(histogram lcons_ses if milieu==2 [fweight=fwt],width(0.1) lcolor(blue) lw(vvthin) fcolor(none) fintensity(inten10) disc den) if lcons_ses>=-3.5 & lcons_ses<=3.5,legend(order(1 "Urban" 2 "Rural")) xtitle("Normalized log consumption-adjust- Trimmed")




* Calculating the gini, method 1
ineqdeco tot_cons2ses
ineqdeco tot_cons2ses, by(milieu)
* Calculating the marginal distributions and the gini, method2
pshare tot_cons2ses [fweight=fwt], percent n(5) gini
pshare tot_cons2ses [fweight=fwt], percent p(1 5 10 90 95 99) gini

pshare tot_cons2ses [pweight=hhweight1], percent n(5) gini
pshare tot_cons2ses if milieu==1 [pweight=hhweight1], percent n(5) gini
pshare tot_cons2ses if milieu==2 [pweight=hhweight1], percent n(5) gini








