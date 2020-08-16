data<-readMat("/Users/yunjiangge/Dropbox/Weigthed_cluster_extent/updated1122_newdata/smttest_4/smttest30_8_4.mat")
pdata<-data$spval
tdata<-data$stval
##truth
mat<-matrix(rep(0,10000),nrow=100)
# These are signifcant ones
mat[40:60,40:60]<-1 # Cluster 1, a total of 441 significant voxels
mat[10:15,85:90]<-1 # Cluster 2, a total of 36 significant voxels
# Convert the matrix into a vector, same purpose as ind2sub
matv<-as.vector(mat)
primarythres<-function(tdata,pdata,samp,breaks)#truebar,multipower)
{
  matt3<-matt2<-matt1<-matt<-c(rep(0,10000))
  
  thres<-locfdr(tdata,bre=500,plot=0)
  p1f1<-thres$mat[,11]
  f<-thres$mat[,5]
  f0<-thres$mat[,6]
  p0<-thres$fp0[3,3]
  p1<-1-p0
  f1<-p1f1/p1
  sort_zval<-thres$mat[,1]
  
  TDR<-TPR<-Fdr<-c()
  for (i in 1:length(sort_zval))
  {
    TDR[i]<-p1*sum(f1[(length(sort_zval)-i):length(sort_zval)])/sum(f[(length(sort_zval)-i):length(sort_zval)])
    TPR[i]<-sum(f1[(length(sort_zval)-i):length(sort_zval)])/sum(f1)
    Fdr[i]<-1-TDR[i]
  }
  
  F1<-2*(TDR*TPR/(TDR+TPR))
  
  #plot(1:499,F1,type = "o",col="blue",ylim = c(0,1))
  #points(1:499,TDR,col="red",pch="*")
  #points(1:499,TPR,col="dark red",pch="+")
  #legend(0,1,legend = c("F1","TDR","TPR"),col=c("blue","red","dark red"),lty=c(1,2,3),pch = c("o","*","+"),ncol=1)
  
  #below are the code for finding convex interval
  #conv_list<-function(num,TPR,TDR,F1)
  #{
  sec_TPR<-sec_F1<-sec_TDR<-c()
  sec_TPR[1]<-TPR[3]-2*TPR[2]+TPR[1]
  sec_TDR[1]<-TDR[3]-2*TDR[2]+TDR[1]
  sec_F1[1]<-F1[3]-2*F1[2]+F1[1]
  sec_TPR[breaks-1]<-TPR[breaks-1]-2*TPR[breaks-1-1]+TPR[breaks-1-2]
  sec_TDR[breaks-1]<-TDR[3]-2*TDR[breaks-1-1]+TDR[breaks-1-2]
  sec_F1[breaks-1]<-F1[3]-2*F1[breaks-1-1]+F1[breaks-1-2]
  for(i in 2:(breaks-1-1))
  {sec_TPR[i]=TPR[i+1]-2*TPR[i]+TPR[i-1]
  sec_TDR[i]=TDR[i+1]-2*TDR[i]+TDR[i-1]
  sec_F1[i]=F1[i+1]-2*F1[i]+F1[i-1]}
  result<-cbind(sec_TPR,sec_TDR,sec_F1)
  #return(result)}
  
  idx_f<-lst<-t1<-t2<-t3<-t4<-t5<-t6<-t7<-t8<-t9<-t10<-t11<-t12<-t13<-t14<-t15<-t16<-t17<-t18<-t19<-t_all<-tt<-out1<-finalthres<-c()
  idx_f<-intersect(which(sec_F1<0),which(sec_TDR<0))
  lst<-cbind(TPR[idx_f],TDR[idx_f],F1[idx_f])
  up_bound<-round(min(lst[,2])*100)
  if(up_bound>95)
  {
    t0<-which(lst[,2]<=up_bound/100)[1]-1
    t_all<-t0
  } else {
    t1<-which(lst[,2]<=0.98)[1]-1
    t2<-which(lst[,2]<=0.97)[1]-1
    t3<-which(lst[,2]<=0.96)[1]-1
    t4<-which(lst[,2]<=0.95)[1]-1
    t5<-which(lst[,2]<=0.94)[1]-1
    t6<-which(lst[,2]<=0.93)[1]-1
    t7<-which(lst[,2]<=0.92)[1]-1
    t8<-which(lst[,2]<=0.91)[1]-1
    t9<-which(lst[,2]<=0.90)[1]-1
    t10<-which(lst[,2]<=0.89)[1]-1
    t11<-which(lst[,2]<=0.88)[1]-1
    t12<-which(lst[,2]<=0.87)[1]-1
    t13<-which(lst[,2]<=0.86)[1]-1
    t14<-which(lst[,2]<=0.85)[1]-1
    t15<-which(lst[,2]<=0.84)[1]-1
    t16<-which(lst[,2]<=0.83)[1]-1
    t17<-which(lst[,2]<=0.82)[1]-1
    t18<-which(lst[,2]<=0.81)[1]-1
    t19<-which(lst[,2]<=0.80)[1]-1
    t20<-which(lst[,2]<=0.79)[1]-1
    t21<-which(lst[,2]<=0.78)[1]-1
    t22<-which(lst[,2]<=0.77)[1]-1
    t23<-which(lst[,2]<=0.76)[1]-1
    t24<-which(lst[,2]<=0.75)[1]-1
    t25<-which(lst[,2]<=0.74)[1]-1
    t26<-which(lst[,2]<=0.73)[1]-1
    t27<-which(lst[,2]<=0.72)[1]-1
    t28<-which(lst[,2]<=0.71)[1]-1
    t29<-which(lst[,2]<=0.70)[1]-1
    t30<-which(lst[,2]<=0.65)[1]-1
    t31<-which(lst[,2]<=0.60)[1]-1
    t32<-which(lst[,2]<=0.55)[1]-1
    t33<-which(lst[,2]<=0.50)[1]-1
    t34<-which(lst[,2]<=0.45)[1]-1
    t35<-which(lst[,2]<=0.40)[1]-1
    t36<-which(lst[,2]<=0.35)[1]-1
    t37<-which(lst[,2]<=0.30)[1]-1
    t38<-which(lst[,2]<=0.25)[1]-1
    t39<-which(lst[,2]<=0.20)[1]-1
    t40<-which(lst[,2]<=0.15)[1]-1
    t41<-which(lst[,2]<=0.10)[1]-1
    t_all<-c(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38,t39,t40,t41)
    
  }
  
  
  tt<-unique(t_all)
  tt<-tt[tt!=0]
  tt<-tt[!is.na(tt)]
  for (i in 1:length(tt))
  {out1[i]=which(TDR==lst[tt[i],2])}
  out1<-out1[!is.na(out1)]
  
  if(length(out1)==0){
    return(0) 
  }else  {
    
    if(mean(p1f1)==0) {
      finalthres<-1 
    } else {
      for (i in 1:length(tt)) 
      {finalthres[i]<-pt(thres$mat[length(sort_zval)-out1[i],1][[1]],samp*2-2,lower.tail = FALSE)}
    }
    
    if(length(finalthres)==1){
      dataout<-c(lst[tt,],finalthres)
    } else {
      dataout<-cbind(lst[tt,],finalthres)
      dataout[!is.na(dataout[,4]), ]
      n<-length(dataout[,1])
      if(dataout[n-1,2]-dataout[n,2]<0.09)
      {dataout<-dataout[-n,]}
    }
    return(dataout)}
}


result08_smt4_30<-list()
for (i in 1:100)
{
  pdata<-data$spval[[i]][[1]][1:10000]
  tdata<-data$stval[[i]][[1]][1:10000]
  
  result08_smt4_30[[i]]<-primarythres(tdata,pdata,30,500)
  print(i)
}
result08_all_smt4_30<-list()
for (i in 1:100)
{
  pdata<-data$spval[[i]][[1]][1:10000]
  tdata<-data$stval[[i]][[1]][1:10000]
  
  result08_all_smt4_30[[i]]<-primaryall(tdata,pdata,30,500)
  print(i)
}

result08_smt4_60<-list()
for (i in 1:100)
{
  pdata<-data$spval[[i]][[1]][1:10000]
  tdata<-data$stval[[i]][[1]][1:10000]
  
  result08_smt4_60[[i]]<-primarythres(tdata,pdata,60,500)
  print(i)
}
result08_smt4_100<-list()
for (i in 1:100)
{
  pdata<-data$spval[[i]][[1]][1:10000]
  tdata<-data$stval[[i]][[1]][1:10000]
  
  result08_smt4_100[[i]]<-primarythres(tdata,pdata,100,500)
  print(i)
}
#-----------sample=30
result08_smt4_30[[i]]
finalthres<-result08_smt4_30[[i]][j,4]
fdr_rate<-1-result08_smt4_30[[i]][j,2]
pdata<-data$spval[[i]][[1]][1:10000]
fdr_cluster<-length(which(pdata<=finalthres))*fdr_rate
finalthres
fdr_cluster
fdcluster
realtrepos
realtredis
fdr<-fdrcorrectionR(pdata,0.05)
fdr
finalthres<-0.0011
fdr_rate<-1-0.9119398
fdr_cluster_real<-length(which(pdata<=finalthres))*fdr_rate
fdr_cluster_real

#-----------sample=60
fdr_alpha<-min(0.8,max(result_smt4_60[[i]][,2]))
loc<-which(result_all_smt4_60[[i]][,2]<=fdr_alpha+0.01)[1]
finalthres<-result_all_smt4_60[[i]][loc,4]
matt<-c(rep(0,10000))
pdata<-data$spval[[i]][[1]][1:10000]
matt[which(pdata<=finalthres)]<-1
realfalpos<-sum(matt[which(matv %in% 0)])/9523
realtrepos<-sum(matt[which(matv %in% 1)])/477
realtredis<-sum(matt[which(matv %in% 1)])/sum(matt)
dis<-length(matt[which(pdata<=finalthres)])
tre<-sum(matt[which(matv %in% 1)])
fdcluster<-dis-tre
finalthres
dis
fdcluster
realtrepos
realtredis
result_smt4_60[[i]]
pval_fdr<-data$spval[[i]][[1]][1:10000]
fdr<-fdrcorrectionR(pval_fdr,0.05)
fdr

#-----------sample=100
fdr_alpha<-min(0.8,max(result_smt4_100[[i]][,2]))
loc<-which(result_all_smt4_100[[i]][,2]<=fdr_alpha+0.01)[1]
finalthres<-result_all_smt4_100[[i]][loc,4]
matt<-c(rep(0,10000))
pdata<-data$spval[[i]][[1]][1:10000]
matt[which(pdata<=finalthres)]<-1
realfalpos<-sum(matt[which(matv %in% 0)])/9523
realtrepos<-sum(matt[which(matv %in% 1)])/477
realtredis<-sum(matt[which(matv %in% 1)])/sum(matt)
dis<-length(matt[which(pdata<=finalthres)])
tre<-sum(matt[which(matv %in% 1)])
fdcluster<-dis-tre
finalthres
dis
fdcluster
realtrepos
realtredis
result_smt4_100[[i]]
pval_fdr<-data$spval[[i]][[1]][1:10000]
fdr<-fdrcorrectionR(pval_fdr,0.05)
fdr


