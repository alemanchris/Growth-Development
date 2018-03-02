* This file adds each individual consumption good and calculates aggregate household consumption

gen cadeau_0=0
replace cadeau_0=cadeau if cadeau!=.
gen achat_0=0
replace achat_0=achat if achat!=.
gen consum=achat_0+cadeau_0

* Create non-durables
* Food consumption
gen food=0
#delimit ;
replace food=1 
          if product <=65 | product==81 | product==82;
#delimit cr
* Non-Food Consumption
* Expenditure in Energy
gen energy=0
#delimit ;
replace energy=1 
          if product!=81 & product!=82 & product >65 & product <=76;
#delimit cr
* Basic Services
gen services=0
#delimit ;
replace services=1 
          if product==100 | product==101 | product==102 | product==103 
		  | product==104 | product==105; 
		  
#delimit cr
* Others
gen others=0
#delimit ;
replace others=1 
          if product!=100 & product!=101 & product!=102 & product!=103 
		  & product!=104 & product!=105 & product!=81 & product!=82 
		  & product >76 & product <124 | product >=148 & product <161 
		  | product >=168 & product <=182 | product >=195 & product <=200
		  | product >=202 & product <=211;
		  
#delimit cr
***Example product

/*
gen others=0
#delimit ;
replace others=1 
          if product!=1 & product!=2  
		  & product >4 & product <7 | product >=12 & product <16 
		  | product >=17 & product <=18;
		  
#delimit cr
*/

*5 6 yes
* 12, 13 14 15
* 17 18
*NON-DURABLES
gen non_dur=0
replace non_dur=1 if food==1 | energy==1 | services==1 | others==1
* Only sum non-durables

egen tot_cons=total(consum) if non_dur==1 , by(hhid)
replace tot_cons=tot_cons*4  //Montly nominal consumption *4 =Yearly consulption
* this is just completing the missings
egen tot_cons2=mean(tot_cons), by(hhid) 
egen weight2=mean(hhweight1), by(hhid) 
drop hhweight1
gen hhweight1=weight2
