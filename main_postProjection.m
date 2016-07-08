%% File to process data
clear all;
load('horizontalData2.mat');
[m,n]=size(collatedd);
tfinal=[];
debFzfinal=[];
debFyfinal=[];
debFxfinal=[];
passno=1;
subject=4;
figure();
tdes=0:0.005:1;
Fmag=[];
%% To store data in different rows corresponding to different passes
for i=1:n
    nameStr=collatedName{i}{1};
    t=collatedt{i};
    debFx=collateddebFx{i};
    debFy=collateddebFy{i};
    debFz=collateddebFz{i};
    pt1=min(t);
    pt2=max(t);
    tRe=[];
    
    for j=1:length(t)
        tRe(j)=(t(j)-pt1)/(pt2-pt1);
    end

    if abs(tRe(1)-1) < abs(tRe(1)-0)
        tRe=1-tRe;
    end
    
    if str2num(nameStr(22))==subject %&& str2num(nameStr(17))==1
        %nameStr
        if (str2num(nameStr(28))==3 || str2num(nameStr(28))==9) %&& str2num(nameStr(34))==passno
            tfinal=[tfinal, tRe];
            %length(tfinal)
            debFxfinal=[debFxfinal,abs(debFx)];
            debFyfinal=[debFyfinal,abs(debFy)];
            debFzfinal=[debFzfinal,abs(debFz)];
            debFxInterp(i,:)=interp1(tRe, smooth(debFx,10),tdes);
            debFyInterp(i,:)=interp1(tRe, smooth(debFy,10),tdes);
            debFzInterp(i,:)=interp1(tRe, smooth(debFz,10),tdes);
            a=sqrt(debFxInterp.^2+debFyInterp.^2+debFzInterp.^2);
            plot(tdes,a(end,:),'DisplayName',nameStr(28));
            hold on;
            hold all;
            legend('-DynamicLegend');
            Fmag=[Fmag;a(end,:)];
%             plot(tdes,abs(debFzInterp(i,:)));
%             plot(tRe,smooth(debFx,10));
          
        elseif (str2num(nameStr(28))==1 && sum(isstrprop(nameStr(28:29),'digit'))~=2) %&& str2num(nameStr(34))==passno
            tfinal=[tfinal, tRe];
            %length(tfinal)
            debFxfinal=[debFxfinal,abs(debFx)];
            debFyfinal=[debFyfinal,abs(debFy)];
            debFzfinal=[debFzfinal,abs(debFz)];
            debFxInterp(i,:)=interp1(tRe, smooth(debFx,10),tdes);
            debFyInterp(i,:)=interp1(tRe, smooth(debFy,10),tdes);
            debFzInterp(i,:)=interp1(tRe, smooth(debFz,10),tdes);
            a=sqrt(debFxInterp.^2+debFyInterp.^2+debFzInterp.^2);
            plot(tdes,a(end,:),'DisplayName',nameStr(28));
            hold on;
            hold all;
            legend('-DynamicLegend');
            Fmag=[Fmag;a(end,:)];
%             plot(tdes,abs(debFzInterp(i,:)));
%             plot(tRe,smooth(debFx,10));
%             
        elseif sum(isstrprop(nameStr(28:29),'digit'))==2 && str2num(nameStr(28:29))==11 %&& str2num(nameStr(35))==passno
            tfinal=[tfinal, tRe];
            %length(tfinal)
            debFxfinal=[debFxfinal,abs(debFx)];
            debFyfinal=[debFyfinal,abs(debFy)];
            debFzfinal=[debFzfinal,abs(debFz)];
            debFxInterp(i,:)=interp1(tRe, smooth(debFx,10),tdes);
            debFyInterp(i,:)=interp1(tRe, smooth(debFy,10),tdes);
            debFzInterp(i,:)=interp1(tRe, smooth(debFz,10),tdes);
            a=sqrt(debFxInterp.^2+debFyInterp.^2+debFzInterp.^2);
            plot(tdes,a(end,:),'DisplayName',nameStr(28:29));
            hold on;
            hold all;
            legend('-DynamicLegend');
            Fmag=[Fmag;a(end,:)];
%             plot(tdes,abs(debFzInterp(i,:)));
%             plot(tRe,smooth(debFx,10));
        end
    end
end

%% Average forces for whatever is kept constant (subject and pass no. for horizontal edges only for instance)
[m,n]=size(Fmag);
forceAveraged=mean(Fmag);

S=std(Fmag);
% 95% confidence interval
upperLt=forceAveraged+1.96*S/sqrt(n);
lowerLt=forceAveraged-1.96*S/sqrt(n);
figure();
xvals=[tdes,fliplr(tdes)];
yvals=[upperLt,fliplr(lowerLt)];
fill(xvals,yvals,'b');
hold on;
plot(tdes,forceAveraged);
plot(tdes,upperLt);
plot(tdes,lowerLt);


[m,n]=size(Fmag);
forceAveragedMean=mean(forceAveraged)
for i=1:m
    forceNormalized(i,:)=Fmag(i,:)/forceAveragedMean;
end
figure();
plot(tdes,forceNormalized);
forceNormalizedAveraged=mean(forceNormalized);
S2=std(forceNormalizedAveraged);
upperLtNormalized=forceNormalizedAveraged+1.96*S2/sqrt(n);
lowerLtNormalized=forceNormalizedAveraged-1.96*S2/sqrt(n);
savename=strcat('horizontal_sub',num2str(subject));
save(savename);