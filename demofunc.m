function [TDR_m,TDR_1,TDR_p,TPR_m,TPR_1,TPR_p,permbound,permbound_1,permbound_m,fdrbound,fdrbound_1,fdrbound_m]=demofunc(prminput,samplesize,fn,inflated_fn,loop)
load('/Users/yunjiangge/eBass/sampledata.mat');
% data here is close the test statistics for all voxels 
data=zeros(100,100);
%these are signifcant ones
data(40:60,40:60)=1; % cluster 1
data(10:15,85:90)=1;
orgidx=data(:);

%here the simulation for one set of graph data starts
sampsize=samplesize;
image_data=data1;
permloop=loop;
prmthres=prminput;
Tmin_perm= [];
Tmax_fdr=[];
permbound=[];
fn=fn;

%parpool(6);
parfor m = 1:permloop
%1. relabeling
    group_perm1 = randsample(sampsize*2,sampsize);
    group_perm0 = setdiff([1:sampsize*2],group_perm1);
    perm_order(:,m) = [ group_perm1' group_perm0 ];

%2. t-test
P_sim=[];
sig1d1=[];
CC=[];
a=[];
dd=[];

    for j=1: (size(image_data,1))    
    x=image_data(j,group_perm1);
    y=image_data(j,group_perm0);
    
    T=(mean(x)-mean(y))/sqrt(var(x)/sampsize+var(y)/sampsize);
    P_sim(j)=2*(1-tcdf(abs(T),2*sampsize-2));
    end
%3. find clusters
    
    %signficant index
     sig1d1=find(P_sim<=prmthres);    
    datatest=zeros(100,100);
    datatest(sig1d1)=1;
    CC=bwconncomp(datatest);
    [a,~]=cellfun(@size,CC.PixelIdxList(:));
    dd=CC.PixelIdxList(a>1);%dd is C_sig
    
    %4(a):find out the largest cluster size of each simulation
    l=[];
    for d=1:length(dd)
        l(d)=length(dd{d});
    end
   
    if isempty(l)
        Tmin_perm(m)=1;
    else
        Tmin_perm(m)= max(l);
    end
    
    
    %4. find min false discovery cluster size
    P_new=sort(P_sim);
    sig1d2=find(P_sim<=P_new(inflated_fn));
    sig1d3=sig1d2(randperm(length(sig1d2),fn));
    datatest1=zeros(100,100);
    datatest1(sig1d3)=1;
    CC1=bwconncomp(datatest1);
    [a1,~]=cellfun(@size,CC1.PixelIdxList(:));
    dd1=CC1.PixelIdxList(a1>1);%dd is C_sig
    
    %4(a):find out the largest cluster size of each simulation
    l1=[];
    for d=1:length(dd1)
        l1(d)=length(dd1{d});
    end
   
    if isempty(l1)
        Tmax_fdr(m)=1;
    else
        Tmax_fdr(m)= max(l1);
    end
    
     %m %counter    
    
end


Tmin_perm = sort(Tmin_perm);
permbound_m=max(Tmin_perm);
permbound_1 = Tmin_perm(permloop-round(0.01*permloop));
permbound = Tmin_perm(permloop-round(0.05*permloop));

Tmax_fdr = sort(Tmax_fdr);
fdrbound_m=max(Tmax_fdr);
fdrbound_1 = Tmax_fdr(permloop-round(0.01*permloop));
fdrbound = Tmax_fdr(permloop-round(0.05*permloop));

%3. find clusters
    
pval=data2;
sig1d1=[];datatest=[];CC=[];dd=[];C_sig=[];nrows=[];
    %signficant index
     sig1d1=find(pval<prmthres);    
    datatest=zeros(100,100);
    datatest(sig1d1)=1;
    CC=bwconncomp(datatest);
    [a,~]=cellfun(@size,CC.PixelIdxList(:));
    dd=CC.PixelIdxList(a>1);%dd is C_sig
    
    C_sig=dd;
    
    %calculate TPR for perm
    indices_p=[];indices_1=[];indices_m=[];TDR_m=[];TDR_1=[];TDR_p=[];TPR_m=[];TPR_1=[];TPR_p=[];
[nrows,~]=cellfun(@size,C_sig);
indices_p = vertcat(C_sig{1,nrows>=permbound});
indices_1 = vertcat(C_sig{1,nrows>=permbound_1});
indices_m = vertcat(C_sig{1,nrows>=permbound_m});
TDR_m = sum(orgidx(indices_m))/length(intersect(indices_m,sig1d1));
TDR_1 = sum(orgidx(indices_1))/length(intersect(indices_1,sig1d1));
TDR_p = sum(orgidx(indices_p))/length(intersect(indices_p,sig1d1));
TPR_m = sum(orgidx(indices_m))/477;
TPR_1 = sum(orgidx(indices_1))/477;
TPR_p = sum(orgidx(indices_p))/477;

end


    