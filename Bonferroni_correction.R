##function for Bonferroni-correction
#p -vector of p-values
#q - uncorrected threshold: 0.05 or 0.1 usually
bonfcorrection<-function(p,q)
{
  v=length(p)
  pcor=q/v
  return(pcor)
}