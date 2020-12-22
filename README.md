# eBass
## Overview
The **eBass** package is the implementation of empirical Bayes Adaptive Threshold Selection method. 
In theory, the method consists of three steps:

1. Calculate the empirial Bayes estimated TPR, TDR and objective function by R package [locfdr](https://cran.r-project.org/web/packages/locfdr/index.html)
2. Identify the support <img src="http://latex.codecogs.com/svg.latex?\Omega_\alpha" title="http://latex.codecogs.com/svg.latex?\Omega_\alpha" /> by our customized R function [primarythres.R](https://github.com/yierge/eBass/blob/master/primarythres.R) and permutation test
3. Search the optimal solution to the objective function on the support.

Below is the instruction on how to run the multi-script procedure based on the sample data.

### Part 1
- **Load dataset**
    - The sample dataset [sampledata.mat](https://github.com/yierge/eBass/blob/master/sampledata.mat) is a data list that contains the image data on each voxels for all subjects (a 10000 by 60 matrix), p-values of each voxel (1 by 10000 vector), and T scores of each voxel (1 by 10000 vector). 
    - In the .R script part, only T score and p-values are required and need to be transformed into vector if you are trying the code with other datasets (let pdata<-**p-value**, tdata<-**T score**).

- **Empirical Bayes estimate**
    - The empirical Bayes estimate is given by existing R package [locfdr](https://cran.r-project.org/web/packages/locfdr/index.html). The main function requires minimum imputs include T/Z score, with the rest of the parameters by default.
    - In the sample data, we only specify the number of breaks (100) for the calculation speed and supress the plot output.

- **Calculate TDR, TPR (Sensitivity) and Objective Function**
    - All values come from the locfdr output.

The above steps are done in R with the function [primarythres.R](https://github.com/yierge/eBass/blob/master/primarythres.R). The inputs are T scores, number of subjects per arm (current version is for two arms design), and number of breaks. The output is a data frame with 5 columns (Sentivity, TDR, Objective Function, T-score, Primary Threshold).

### Part 2
- **Prepare calculating the support <img src="http://latex.codecogs.com/svg.latex?\Omega_\alpha" title="http://latex.codecogs.com/svg.latex?\Omega_\alpha" />**
    - Copy and paste the following code in R
    ```
    #we restricted the search region to p-value less than 0.02 since 0.01 is already considered liberal primary threshold but not totally unacceptable
    idx<-length(which(ebass_est[,5]<0.02))
    sort_p<-sort(pdata)     
    vox_num<-fdr_cut<-loc<-results<-c()
    for (i in 1:idx)
    {
    vox_num[i]<-length(which(pdata<=ebass_est[i,5]))
    loc[i]<-ceiling(vox_num[i]*(1-ebass_est[i,2]))     
    fdr_cut[i]<-sort_p[loc[i]]
    }
    results<-as.data.frame(cbind(ebass_est[1:idx,5], fdr_cut,vox_num,loc,ebass_est[1:idx,3]))
    names(results)<-c("PrmThres","fdr_cutoff","suprathres_voxnum","false_supra_voxnum","ObjFunc")
    #uncomment results if you want to check your output
    #results 
    ```
    - Save the output to local for MATLAB code input
    ```
    #change /... to your local route 
    writeMat('/...', x=as.matrix(results))
    ```
    
### Part 3
- **Permutation test from MATLAB**
     - Download the MATLAB script [demofunc.m](https://github.com/yierge/eBass/blob/master/demofunc.m) and [demo_run.m](https://github.com/yierge/eBass/blob/master/demo_run.m).
     - [demofunc.m](https://github.com/yierge/eBass/blob/master/demofunc.m) requires the inputs: image data on each voxels for all subjects, primary threshold, subjects per arm, number of false positive voxels, number of permutation tests. The output includes the cluster-size threshold of permutation test (at 5%) and false positive cluster-size bound (at 1% or max). 
     - In our sample data, image data on each voxels for all subjects is __data1__; primary threshold(s) is(are) given from Part1&2 output; subjects per arm is 30; number of false positive voxels is(are) given from Part1&2 output; number of permutation tests is 300.
- **Search for the cutoff**
     - demofunc.m was running within a potential for-loop (multiple T/Z scores in the search region).
     - Cutoff is given at the last T/Z score that satisfies fdr bound is less than or equal to permutation test bound.
     - The value __ebass__ is the eBass threshold.
     - The code under the comment line "%-----------------below is to check and compare the sensitivity and voxel-wise TDR------------" is used to calculate the sensitivity and voxel-wise TDR if the underlying truth is known. In our demo, the truth is known so we further match the findings with the truth.
     - For demo run, just change the file route at load() from line 1 (R output: test.mat) and line 2 (sampledata.mat) and run the script directly. 
     - If you are running your own data, comment out code following the instructions in the [demo_run.m](https://github.com/yierge/eBass/blob/master/demo_run.m).
- **Display the results**
     - Copy and paste the following code in R and change the route (/.../ part in readMat) to where 'final_out.mat' located.
     ```
     data_out <- readMat('/.../final_out.mat')
     c1<-c(data_out$ebass,data_out$perm.boundbass,data_out$TPR.ebass,data_out$TDR.ebass)
     c2<-c(0.001,data_out$perm.bound001,data_out$TPR.001,data_out$TDR.001)
     output<-cbind(c1,c2)
     rownames(output)<-c("PrmThres","ClusThres","Sensitivity","TDR")
     colnames(output)<-c("eBass","0.001")
     output
     ```
     - The results from sample data include primary threshold (__PrmThres__), cluster-size threshold (__ClusThres__), sensitivity (__Sensitivity__) and TDR (__TDR__) for eBass and 0.001.
     
## Additional Information
     
     
     
     
     
     
     
