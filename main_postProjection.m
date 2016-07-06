%% File to process data
clear all;
load('horizontalData.mat');
[m,n]=size(collatedd);
tfinal=[];
debFzfinal=[];
debFyfinal=[];
debFxfinal=[];
passno=1;
subject=3;
figure()
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
    
    if str2num(nameStr(22))==subject
        %nameStr
        if (str2num(nameStr(28))==3 || str2num(nameStr(28))==9) && str2num(nameStr(34))==passno
            tfinal=[tfinal, tRe];
            %length(tfinal)
            debFxfinal=[debFxfinal,abs(debFx)];
            debFyfinal=[debFyfinal,abs(debFy)];
            debFzfinal=[debFzfinal,abs(debFz)];
            %plot(tRe,smooth(sqrt(debFz.^2+debFy.^2+debFz.^2),10));
            hold on;
        elseif (str2num(nameStr(28))==1 && sum(isstrprop(nameStr(28:29),'digit'))~=2) && str2num(nameStr(34))==passno
            tfinal=[tfinal, tRe];
            %length(tfinal)
            debFxfinal=[debFxfinal,abs(debFx)];
            debFyfinal=[debFyfinal,abs(debFy)];
            debFzfinal=[debFzfinal,abs(debFz)];
            plot(tRe,smooth(debFz,10));
            %plot(tRe,smooth(sqrt(debFz.^2+debFy.^2+debFz.^2),10));
            hold on;
        elseif sum(isstrprop(nameStr(28:29),'digit'))==2 && str2num(nameStr(28:29))==11 && str2num(nameStr(35))==passno
            tfinal=[tfinal, tRe];
            %length(tfinal)
            debFxfinal=[debFxfinal,abs(debFx)];
            debFyfinal=[debFyfinal,abs(debFy)];
            debFzfinal=[debFzfinal,abs(debFz)];
            plot(tRe,smooth(debFz,10));
            %plot(tRe,smooth(sqrt(debFz.^2+debFy.^2+debFz.^2),10));
            hold on;
        end
    end
end