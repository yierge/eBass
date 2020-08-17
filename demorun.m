load('/Users/yunjiangge/eBass/prminput.mat');
prm_input=prminput.PrimaryThres;
inflated_fn=prminput.Infcluster;
fn=prminput.FDRcluster;
loop=10;

for i=1:length(fn)
[TDR_m(i),TDR_1(i),TDR_p(i),TPR_m(i),TPR_1(i),TPR_p(i),permbound(i),permbound_1(i),permbound_m(i),fdrbound(i),fdrbound_1(i),fdrbound_m(i)]=demofunc(prm_input(i),30,fn(i),inflated_fn(i),loop);
i
end
permbound
fdrbound_m
TPR_p
TDR_p
prm_input