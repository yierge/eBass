load('/Users/bright1/Dropbox/eBass/test.mat')
load('/Users/bright1/Dropbox/eBass/sampledata.mat')

for i=1:length(x)
[Tmax_fdr,Tmin_perm]=demofunc(data1,x(i,1),30,x(i,4),300);
Tmax_fdr=sort(Tmax_fdr);
Tmin_perm=sort(Tmin_perm);
fdr_bound(i)=Tmax_fdr(296);
perm_bound(i)=Tmin_perm(284);
end

final=max(find(fdr_bound<=perm_bound))
ebass=x(final,1)


data=zeros(100,100);
%these are signifcant ones
data(40:60,40:60)=1; % cluster 1
data(10:15,85:90)=1;
orgidx=data(:);

sig1d2=find(data2<=ebass);
    datatest1=zeros(100,100);
    datatest1(sig1d2)=1;
    CC1=bwconncomp(datatest1);
    [a1,~]=cellfun(@size,CC1.PixelIdxList(:));
    dd1=CC1.PixelIdxList(a1>=1);%dd is C_sig
    
    C_sig=dd1;
    indices_ebass = vertcat(C_sig{1,a1>=perm_bound(final)});  %comment out if the underlying truth is unknown
   TDR_ebass = sum(orgidx(indices_ebass))/length(intersect(indices_ebass,sig1d2)) %comment out if the underlying truth is unknown
 TPR_ebass = sum(orgidx(indices_ebass))/477  %comment out if the underlying truth is unknown
perm_boundbass=perm_bound(final);
    
%save final_out ebass perm_boundbass 
%-----------------below is to check and compare the sensitivity and voxel-wise TDR------------


 [Tmax_fdr,Tmin_perm]=demofunc(data1,0.001,30,10,300);
Tmin_perm=sort(Tmin_perm);

perm_bound001=Tmin_perm(284);
 sig1d1=find(data2<0.001);    
    datatest=zeros(100,100);
    datatest(sig1d1)=1;
    CC=bwconncomp(datatest);
    [a,~]=cellfun(@size,CC.PixelIdxList(:));
    dd=CC.PixelIdxList(a>=1);%dd is C_sig
    
    C_sig1=dd;
indices_001 = vertcat(C_sig1{1,a>=perm_bound001});
   TDR_001 = sum(orgidx(indices_001))/length(intersect(indices_001,sig1d1))
 TPR_001 = sum(orgidx(indices_001))/477

 save final_out ebass perm_boundbass TPR_ebass TDR_ebass TPR_001 TDR_001 perm_bound001

