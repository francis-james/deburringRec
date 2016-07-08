%% Loads files for different operators and plots them togetger
sub1=load('horizontal_sub1.mat');
sub2=load('horizontal_sub2.mat');
sub3=load('horizontal_sub3.mat');
sub4=load('horizontal_sub4.mat');

tdes=sub1.tdes;
plot(tdes,sub1.forceNormalizedAveraged, 'DisplayName','sub1');
hold on;
plot(tdes,sub2.forceNormalizedAveraged, 'DisplayName','sub2');
plot(tdes,sub3.forceNormalizedAveraged, 'DisplayName','sub3');
plot(tdes,sub4.forceNormalizedAveraged, 'DisplayName','sub4');
legend('-DynamicLegend');

figure();
xvals=[sub1.tdes,fliplr(sub1.tdes)];
yvals=[sub1.upperLtNormalized,fliplr(sub1.lowerLtNormalized)];
fill(xvals,yvals,'b');
hold on;
xvals=[sub2.tdes,fliplr(sub2.tdes)];
yvals=[sub2.upperLtNormalized,fliplr(sub2.lowerLtNormalized)];
fill(xvals,yvals,'g');
xvals=[sub3.tdes,fliplr(sub3.tdes)];
yvals=[sub3.upperLtNormalized,fliplr(sub3.lowerLtNormalized)];
fill(xvals,yvals,'y');
xvals=[sub4.tdes,fliplr(sub4.tdes)];
yvals=[sub4.upperLtNormalized,fliplr(sub4.lowerLtNormalized)];
fill(xvals,yvals,'r');
hold on;
plot(tdes,sub1.forceNormalizedAveraged, 'DisplayName','sub1');
plot(tdes,sub2.forceNormalizedAveraged, 'DisplayName','sub2');
plot(tdes,sub3.forceNormalizedAveraged, 'DisplayName','sub3');
plot(tdes,sub4.forceNormalizedAveraged, 'DisplayName','sub4');
legend('-DynamicLegend');