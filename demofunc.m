function [Tmax_fdr,Tmin_perm]=demofunc(img_data1,prminput,samplesize,fn,loop)
%load('/Users/yunjiangge/eBass/sampledata.mat');
% data here is close the test statistics for all voxels 
data=zeros(100,100);
%these are signifcant ones
data(40:60,40:60)=1; % cluster 1
data(10:15,85:90)=1;
orgidx=data(:);

%here the simulation for one set of graph data starts
image_data=img_data1;
prmthres=prminput;
sampsize=samplesize;

fn=fn;
Tmin_perm= [];
Tmax_fdr=[];
permbound=[];

%parpool(6);
parfor m = 1:loop
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
    sig1d2=find(P_sim<=P_new(fn));
    datatest1=zeros(100,100);
    datatest1(sig1d2)=1;
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



end


    