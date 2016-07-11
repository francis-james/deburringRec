%% Loads files for different operators and plots them togetger
clear all;
sub{1}=load('horizontal_sub1.mat');
sub{2}=load('horizontal_sub2.mat');
sub{3}=load('horizontal_sub3.mat');
sub{4}=load('horizontal_sub4.mat');

tdes=sub{1,1}.tdes;
for i=1:length(sub)
    forceNormalizedAveraged(i,:)=sub{1,i}.forceNormalizedAveraged;
end
[m,n]=size(forceNormalizedAveraged);
meanAcrossOperators=mean(forceNormalizedAveraged);
S=std(forceNormalizedAveraged);
upperLtNormalized=meanAcrossOperators+1.96*S/sqrt(n);
lowerLtNormalized=meanAcrossOperators-1.96*S/sqrt(n);
xvals=[tdes,fliplr(tdes)];
yvals=[upperLtNormalized,fliplr(lowerLtNormalized)];
fill(xvals,yvals,'b');
title('Average of Normalized forces across operators')

figure()
forceAllMagnitude=[];
forceAllNormalized=[];
for i=1:length(sub)
    forceNormalizedAveraged(i,:)=sub{1,i}.forceNormalizedAveraged;
    forceAllMagnitude=[forceAllMagnitude;sub{1,i}.Fmag];
    forceAllNormalized=[forceAllNormalized;sub{1,i}.forceNormalized];
    plot(forceNormalizedAveraged(i,:));
    hold on;
end
title('Average individual normalized forces');


figure()
[m,n]=size(forceAllNormalized);
S2=std(forceAllNormalized);
% for i=1:m
%     plot(forceAllNormalized(i,:));
%     hold on;
% end
upperLtNormalized=mean(forceAllNormalized)+1.96*S2/sqrt(n);
lowerLtNormalized=mean(forceAllNormalized)-1.96*S2/sqrt(n);
xvals=[tdes,fliplr(tdes)];
yvals=[upperLtNormalized,fliplr(lowerLtNormalized)];
h=fill(xvals,yvals,'b');
set(h,'facealpha',.3)
hold on;
plot(tdes,mean(forceAllNormalized));
title('Normalized forces across operators');

% 
% tdes=sub1.tdes;
% plot(tdes,sub1.forceNormalizedAveraged, 'DisplayName','sub1');
% hold on;
% plot(tdes,sub2.forceNormalizedAveraged, 'DisplayName','sub2');
% plot(tdes,sub3.forceNormalizedAveraged, 'DisplayName','sub3');
% plot(tdes,sub4.forceNormalizedAveraged, 'DisplayName','sub4');
% legend('-DynamicLegend');
% title('Normalized forces');
% 
xvals=[sub{1,1}.tdes,fliplr(sub{1,1}.tdes)];
yvals=[sub{1,1}.upperLtNormalized,fliplr(sub{1,1}.lowerLtNormalized)];
fill(xvals,yvals,'b');
hold on;
xvals=[sub{1,2}.tdes,fliplr(sub{1,2}.tdes)];
yvals=[sub{1,2}.upperLtNormalized,fliplr(sub{1,2}.lowerLtNormalized)];
fill(xvals,yvals,'g');
xvals=[sub{1,3}.tdes,fliplr(sub{1,3}.tdes)];
yvals=[sub{1,3}.upperLtNormalized,fliplr(sub{1,3}.lowerLtNormalized)];
fill(xvals,yvals,'y');
xvals=[sub{1,4}.tdes,fliplr(sub{1,4}.tdes)];
yvals=[sub{1,4}.upperLtNormalized,fliplr(sub{1,4}.lowerLtNormalized)];
fill(xvals,yvals,'r');
hold on;
plot(tdes,sub{1,1}.forceNormalizedAveraged, 'DisplayName','sub1');
plot(tdes,sub{1,2}.forceNormalizedAveraged, 'DisplayName','sub2');
plot(tdes,sub{1,3}.forceNormalizedAveraged, 'DisplayName','sub3');
plot(tdes,sub{1,4}.forceNormalizedAveraged, 'DisplayName','sub4');
legend('-DynamicLegend');
title('Normalized forces with 95% confidence intervals');
