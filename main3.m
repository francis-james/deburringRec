clear all;
close all;
files=dir('data/labview/*.csv');
counter=1;
for file=files'
    name=strcat('data/labview/',file.name)
%     name='data/labview/obj1_sub1_edge2_pass1_labview.csv';
    [debFx,debFy,debFz,t,d, debCenter, debRad, debEnd, debX1, debY1, debZ1, ...
    debX2, debY2, debZ2, debX3, debY3, debZ3,A,B,C,D,E,F,G,H]=processData(name);
    animateDeburring(debFx,debFy,debFz,t, debCenter, debRad, debEnd, debX1, debY1, debZ1, ...
    debX2, debY2, debZ2, debX3, debY3, debZ3,A,B,C,D,E,F,G,H);
    h=figure();
    hfig=figure('Name',name);
    hax=axes('Parent',hfig);
    plot(hax,t);
    hold on;
    plot(hax,d);
    plot(hax,debFx);
    plot(hax,debFy);
    plot(hax,debFz);
    name2=strcat(name(1:end-4),'.bmp');
    legend('t','d','Fx','Fy','Fz');
    saveas(hfig,name2);
    %pause()
    close all;
    collateddebFx{counter}=debFx;
    collateddebFy{counter}=debFy;
    collateddebFz{counter}=debFz;
    collatedt{counter}=t;
    collatedd{counter}=d;
    collatedName{counter}=cellstr(name(1:end-4));
    counter=counter+1;
    %break;
end

save('collatedData.mat');