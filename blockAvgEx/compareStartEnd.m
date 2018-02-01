%% See the Speed-up in runtime
blockAvg(2000,2000,20,20)
blockAvgRedo2(2000,2000,20,20)

%% See the difference in the complexity
checkcode('blockAvg.m','-cyc')
checkcode('blockAvgRedo2.m','-cyc')

%% 
edit blockAvg

%%
checkcode blockAvg.m

%% memory allocation
visdiff('blockAvg.m','blockAvgRedo1.m')

%%
blockAvg(2000,2000,20,20)
blockAvgRedo1(2000,2000,20,20)

%% vectorization
doc meshgrid

doc vectorization %reshape

%%
edit blockAvgRedo2.m
visdiff('blockAvgRedo1.m','blockAvgRedo2.m')

%%
blockAvgRedo1(2000,2000,20,20)
blockAvgRedo2(2000,2000,20,20)

