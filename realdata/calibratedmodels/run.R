# This is the main script to run the analysis.

source("readdata.R")
library(MASS)


#This is to generate the data for calibration.
source('generatemuperb.R')
source('generateSigma.R')




#source the .R file in the folder "code".

source('code/Q1year2rho0.2.R')
source('code/Q1year2rho0.4.R')
source('code/Q1year2rho0.05.R')
source('code/Q1year4rho0.2.R')
source('code/Q1year4rho0.4.R')
source('code/Q1year4rho0.05.R')



source('code/Q2year2rho0.2.R')
source('code/Q2year2rho0.4.R')
source('code/Q2year2rho0.05.R')
source('code/Q2year4rho0.2.R')
source('code/Q2year4rho0.4.R')
source('code/Q2year4rho0.05.R')