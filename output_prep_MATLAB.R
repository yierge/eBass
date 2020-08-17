#inputdata is the result from primarythres.R
PrepeBass<-function(testresult)
{
fdr_rate<-inflate_cluster<-c()
for (j in 1:length(testresult[,2]))
{
  finalthres[j]<-testresult[j,6]
  fdr_rate[j]<-1-testresult[j,2]
  fdr_cluster[j]<-length(which(pdata<=finalthres[j]))*fdr_rate[j]
  inflate_cluster[j]<-fdr_cluster[j]*testresult[j,4]

}

results<-as.data.frame(cbind(finalthres, ceiling(fdr_cluster), ceiling(inflate_cluster)))

names(results)<-c("PrimaryThres","FDRcluster","Infcluster")
return(results)
}