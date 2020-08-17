primarythres<-function(tdata,pdata,samp,breaks)#truebar,multipower)
{
  thres<-locfdr(tdata,bre=breaks,plot=0)#can add one more option on image output option
  p1f1<-thres$mat[,11]
  f<-thres$mat[,5]
  f0<-thres$mat[,6]
  p0<-thres$fp0[3,3]
  p1<-1-p0
  f1<-p1f1/p1
  sort_zval<-thres$mat[,1]
  
  #calculate sensitivity and TDR(1-FDR)
  TDR<-TPR<-c()
  for (i in 1:length(sort_zval))
  {
    TDR[length(sort_zval)-i]<-p1*sum(f1[(length(sort_zval)-i):length(sort_zval)])/sum(f[(length(sort_zval)-i):length(sort_zval)])
    TPR[length(sort_zval)-i]<-sum(f1[(length(sort_zval)-i):length(sort_zval)])/sum(f1)
  }
  TDR[length(sort_zval)]<-1
  TPR[length(sort_zval)]<-sum(f1[length(sort_zval)])/sum(f1)
  F1<-2*(TDR*TPR/(TDR+TPR))
  locfdr_rate<-exp(thres$mat[,2])
  finalthres<-pt(sort_zval,samp*2-2,lower.tail = FALSE)
  
 #find optimal region
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
 
  #display optimal points by TDR
  idx_f<-lst<-t0<-t1<-t2<-t3<-t4<-t5<-t6<-t7<-t8<-t9<-t10<-t11<-t12<-t13<-t14<-t15<-t16<-t17<-t18<-t19<-t20<-t21<-t22<-t23<-t24<-t25<-t26<-t27<-t28<-t29<-t30<-t31<-t32<-t33<-t34<-t35<-t36<-t37<-t38<-t39<-t40<-t41<-t42<-t43<-t44<-t45<-t46<-t47<-t48<-t49<-t50<-t51<-t52<-t53<-t54<-t55<-t56<-t57<-t58<-t_all<-tt<-out1<-c()
  idx_f<-intersect(which(sec_F1<0),which(sec_TDR<0))
  lst<-cbind(TPR[idx_f],TDR[idx_f],F1[idx_f],locfdr_rate[idx_f],sort_zval[idx_f],finalthres[idx_f])
  
  t0<-which(lst[,2]>=0.99)[1]-1
    t1<-which(lst[,2]>=0.98)[1]-1
    t2<-which(lst[,2]>=0.97)[1]-1
    t3<-which(lst[,2]>=0.96)[1]-1
    t4<-which(lst[,2]>=0.95)[1]-1
    t5<-which(lst[,2]>=0.94)[1]-1
    t6<-which(lst[,2]>=0.93)[1]-1
    t7<-which(lst[,2]>=0.92)[1]-1
    t8<-which(lst[,2]>=0.91)[1]-1
    t9<-which(lst[,2]>=0.90)[1]-1
    t10<-which(lst[,2]>=0.89)[1]-1
    t11<-which(lst[,2]>=0.88)[1]-1
    t12<-which(lst[,2]>=0.87)[1]-1
    t13<-which(lst[,2]>=0.86)[1]-1
    t14<-which(lst[,2]>=0.85)[1]-1
    t15<-which(lst[,2]>=0.84)[1]-1
    t16<-which(lst[,2]>=0.83)[1]-1
    t17<-which(lst[,2]>=0.82)[1]-1
    t18<-which(lst[,2]>=0.81)[1]-1
    t19<-which(lst[,2]>=0.80)[1]-1
    t20<-which(lst[,2]>=0.79)[1]-1
    t21<-which(lst[,2]>=0.78)[1]-1
    t22<-which(lst[,2]>=0.77)[1]-1
    t23<-which(lst[,2]>=0.76)[1]-1
    t24<-which(lst[,2]>=0.75)[1]-1
    t25<-which(lst[,2]>=0.74)[1]-1
    t26<-which(lst[,2]>=0.73)[1]-1
    t27<-which(lst[,2]>=0.72)[1]-1
    t28<-which(lst[,2]>=0.71)[1]-1
    t29<-which(lst[,2]>=0.70)[1]-1
    t30<-which(lst[,2]>=0.69)[1]-1
    t31<-which(lst[,2]>=0.68)[1]-1
    t32<-which(lst[,2]>=0.67)[1]-1
    t33<-which(lst[,2]>=0.66)[1]-1
    t34<-which(lst[,2]>=0.65)[1]-1
    t35<-which(lst[,2]>=0.64)[1]-1
    t36<-which(lst[,2]>=0.63)[1]-1
    t37<-which(lst[,2]>=0.62)[1]-1
    t38<-which(lst[,2]>=0.61)[1]-1
    t39<-which(lst[,2]>=0.60)[1]-1
    t40<-which(lst[,2]>=0.59)[1]-1
    t41<-which(lst[,2]>=0.58)[1]-1
    t42<-which(lst[,2]>=0.57)[1]-1
    t43<-which(lst[,2]>=0.56)[1]-1
    t44<-which(lst[,2]>=0.55)[1]-1
    t45<-which(lst[,2]>=0.54)[1]-1
    t46<-which(lst[,2]>=0.53)[1]-1
    t47<-which(lst[,2]>=0.52)[1]-1
    t48<-which(lst[,2]>=0.51)[1]-1
    t49<-which(lst[,2]>=0.50)[1]-1
    t50<-which(lst[,2]>=0.45)[1]-1
    t51<-which(lst[,2]>=0.40)[1]-1
    t52<-which(lst[,2]>=0.35)[1]-1
    t53<-which(lst[,2]>=0.30)[1]-1
    t54<-which(lst[,2]>=0.25)[1]-1
    t55<-which(lst[,2]>=0.20)[1]-1
    t56<-which(lst[,2]>=0.15)[1]-1
    t57<-which(lst[,2]>=0.10)[1]-1
    t58<-which(lst[,2]>=0.05)[1]-1
    
    t_all<-c(t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16,t17,t18,t19,t20,t21,t22,t23,t24,t25,t26,t27,t28,t29,t30,t31,t32,t33,t34,t35,t36,t37,t38,t39,t40,t41,t42,t43,t44,t45,t46,t47,t48,t49,t50,t51,t52,t53,t54,t55,t56,t57,t58)
    
  tt<-unique(t_all)
  tt<-tt[tt!=0]
  tt<-tt[!is.na(tt)]
  for (i in 1:length(tt))
  {out1[i]=which(TDR==lst[tt[i],2])}
  out1<-out1[!is.na(out1)]
  
  #preparing the return
  if(length(out1)==0){
    return(0) 
  }else  {
    if(mean(p1f1)==0) {
      finalthres<-1 
    } else {
      dataout<-lst[tt,]
    }
    dataout<-as.data.frame(dataout)
    names(dataout)<-c("Sensitivity","TDR","ObjFunc","InflScale","T-score","PrimaryThres")
    return(dataout)}
}
