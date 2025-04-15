# This is the code for the paper "Estimation of Out-of-Sample Sharpe Ratio for High Dimensional Portfolio Optimization".
# Authors: Xuran Meng, Yuan Cao and Weichen Wang

It consists of experiments with synthetic data and real data. In the folder simuations, it contains all the code for simulation results; In the folder real data, it contains all the code for real data experiment results. Users may pay attention to the working directory. The working directory should be "Sharpe/simulations/sec2/" or "Sharpe/realdata/efficientfrontier/". 

Each subsection has independent working environment.

### Environment and Setup
We use R, Anaconda to conduct simulation. C++ is only applied to accelerate the speed. Researchers may use R to do the matrix manupulations, but it will have a slower speed.

We use vscode to run experiments. Researchers may download the folders on the github to maintain the same directory.



Versions: 
R 4.4.1 Anaconda 24.7.1 clang 1500.3.9.4

### sessionInfo()
R version 4.4.1 (2024-06-14)
Platform: aarch64-apple-darwin20
Running under: macOS Sonoma 14.6.1

Matrix products: default
BLAS:   /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRblas.0.dylib 
LAPACK: /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

time zone: America/Detroit
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] compiler_4.4.1 cli_3.6.3      jsonlite_1.8.8 rlang_1.1.4   


### Simulations

Set the working directory to Simulations/sec2
Run the file basicR and it will store the results. (Obtain all the results with different $n$ )
Run the file plotbase.py plotasymp.py to get the figures.
open the file Run.R, run the code inside and get the comparison in Appendix A.1

Run the file Compareunknownmu.R and get results of unknownmu in Appendix A.2

Run the file optimizefullQ.R and optimizediagQ.R and get results in Appendix A.3

The figures are obtaibed by plotmu.py, plotsigma.py etc.
#### Section 4.2
Set the working directory to Simulations/sec3
Run the file run.R, and then run plotbase.py plotasymp.py to obtain figures.



### Real data Experiments.
### Global min, meanvariance with/without known mu
Set the working directory to Realdata/meanvariance+globalmin
Run.R code in the folder "code", we will get all the results in Section 5.1, Appendix B.1 and Appendix B.3. Each code corresponds to one situation.

Then we can run .py code to obtain the figures.
### Efficient frontier
Set the working directory to Realdata/efficientfrontier
There is a run.R in the folder "code". Directly run the code in run.R, then run py file to obtain figures in Section 5.2.


### Calibrated models
Set the working directory to Realdata/calibratedmodels Directly run the code in run.R, then run the py file in the folder "code" to obtain figures in Appendix B.2.




