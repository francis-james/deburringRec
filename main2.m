%% Animates the deburring motion, segments portions where deburring is happening, plots forces and positions

clear all;
close all;
% files=dir('data/labview/*.csv');
% for file=files'
%     name=strcat('data/labview/',file.name);
% end
name='data/labview/obj3_sub4_edge1_pass1_labview_07_53_13_27_05_2016.csv';
v = VideoWriter('deburring4.avi');
M=csvread(name);
if str2num(name(22))>2
    rectfile='rectangle2.csv';
else
    rectfile='rectangle1.csv';
end
rectPosn=csvread(rectfile);


%%linept on line42
sign=-1;

x1=M(:,9);
y1=M(:,18);
z1=M(:,27);
rectx1=mean(rectPosn(:,9));
recty1=mean(rectPosn(:,18));
rectz1=mean(rectPosn(:,27));

x2=M(:,10);
y2=M(:,19);
z2=M(:,28);
rectx2=mean(rectPosn(:,10));
recty2=mean(rectPosn(:,19));
rectz2=mean(rectPosn(:,28));

x3=M(:,11);
y3=M(:,20);
z3=M(:,29);
rectx3=mean(rectPosn(:,11));
recty3=mean(rectPosn(:,20));
rectz3=mean(rectPosn(:,29));

rectx4=mean(rectPosn(:,12));
recty4=mean(rectPosn(:,21));
rectz4=mean(rectPosn(:,30));

A=[rectx1;recty1;rectz1]+[0;0;0.015875]-[0.0381;0;0]-[0;0.03048;0]%-[0.025;0;0];
B=[rectx2;recty2;rectz2]-[0.0381;0;0]-[0;0;0.015875]-[0;0.03048;0]%-[0.025;0;0];
%B=[rectx2;recty2;rectz2]-[0.0381;0;0]-[0;0;0.015875]-[0;0.03048;0]-[0.025;0;0];
C=[rectx3;recty3;rectz3]+[0;0;0.015875]+[0.0381;0;0]-[0;0.03048;0]%-[0.025;0;0];
D=[rectx4;recty4;rectz4]+[0.0381;0;0]-[0;0;0.015875]-[0;0.03048;0]%-[0.025;0;0];
E=A+[0;0.03048;0];
F=B+[0;0.03048;0];
G=C+[0;0.03048;0];
H=D+[0;0.03048;0];
if strcmp(rectfile,'rectangle2.csv')
    A(3)=C(3);
    E(3)=C(3);
    B(3)=D(3);
    F(3)=D(3);
end


if strcmp(name(28:29),'12') || strcmp(name(28),'2')
    linept1=C;
    linept2=D;
    display('CD');
elseif strcmp(name(28),'3') || strcmp(name(28:29),'11')
    linept1=B;
    linept2=D;
    display('BD');
elseif strcmp(name(28),'4') || strcmp(name(28:29),'10')
    linept1=A;
    linept2=B;
    display('AB');
elseif strcmp(name(28),'1') || strcmp(name(28),'9')
    linept1=A;
    linept2=C;
    display('AC');
elseif strcmp(name(28),'5')
    linept1=E;
    linept2=A;
    display('EA');
elseif strcmp(name(28),'6')
    linept1=B;
    linept2=F;
    display('BF');
elseif strcmp(name(28),'7')
    linept1=D;
    linept2=H;
    display('DH');
elseif strcmp(name(28),'8')
    linept1=C;
    linept2=G;
    display('CG');
end
Fx=M(:,3);
Fy=M(:,4);
Fz=M(:,5);
Mx=M(:,6);
My=M(:,7);
Mz=M(:,8);


%% Start solving for end positions
points=[];
count=0;
r=0.1;
options = optimoptions(@lsqnonlin,'Display','off');
options.Algorithm = 'levenberg-marquardt';

centre=zeros(3,length(x1));
ig=[1;1];
counter1=0;
for i=1:length(x1)
    p1t=[x1(i);y1(i);z1(i)];
    p2t=[x2(i);y2(i);z2(i)];
    p3t=[x3(i);y3(i);z3(i)];
    
    if abs(norm(p1t-p2t)-norm(p1t-p3t))<0.01
        p2=p1t;
        p1=p2t;
        p3=p3t;
    elseif  abs(norm(p2t-p1t)-norm(p2t-p3t))<0.01
        p2=p2t;
        p1=p1t;
        p3=p3t;
    else
        p2=p3t;
        p1=p1t;
        p3=p2t;
    end
    
    %% Detect if marker is far away (false positive+false negative)
    flag=0;
    pts=[p1,p2,p3];
    flagtable=zeros(1,3);
    for cnt1=1:3
        for cnt2=1:3
            if norm(pts(:,cnt1)-pts(:,cnt2))>0.11
                flagtable(cnt1)=flagtable(cnt1)+1;      %if flagtable(i)==2, then that point is too far away to be real data
            end
        end
    end
    
    
    % Get rid of far away points if any
    ptsToFit=[];
    for cnt1=1:3
        if flagtable(cnt1)<2
            if pts(:,cnt1)~=[0;0;0]
                ptsToFit=[ptsToFit,pts(:,cnt1)];
            end
        end
    end
    
    %Do least square fit if no. of valid points is 2, skip if 1, circle fit
    %if 3
    [m,n]=size(ptsToFit);
    if n==1 || n==0
        continue;
    elseif n==2
        %least square fit without using planes
%         p1=ptsToFit(:,1);
%         p2=ptsToFit(:,2);
%         [centre(:,i), ~,~,exitflag(i),output]=lsqnonlin(@(c)minimizeError2(p1,p2,c,r),[0;0;0],[],[],options);
%         if exitflag(i)==0
%             display('No solution found');
%         end
%         nv(:,i)=cross(centre(:,i)-p1,centre(:,i)-p2)/norm(cross(centre(:,i)-p1,centre(:,i)-p2));
        continue;
    else
        [centre(:,i),rad(i),v1n,v2nb, nv(:,i)] = circlefit3d(p1.',p2.',p3.');
        nv(:,i)=nv(:,i)/norm(nv(:,i));

%     %% Uncomment this for least square circle fitting ->Bad
%     
%     % This bit calculates the vectors that parametrize the plane
%     % Start calculation
%     % v1, v2 describe the vectors from p1 to p2 and p3, resp.
%     v1 = p2 - p1;v2 = p3 - p1;
%     % l1, l2 describe the lengths of those vectors
%     l1 = norm(v1);
%     l2 = norm(v2);
%     
%      % v1n, v2n describe the normalized vectors v1 and v2
%     if l1==0 
%         %fprintf('??? Error using ==> cirlefit3d\nCorresponding input points must not be identical.\n');rad = -4;return;
%         v1n=[0;0;0];
%     else
%         v1n = v1/l1;
%     end
%     
%     if l2==0 
%         %fprintf('??? Error using ==> cirlefit3d\nCorresponding input points must not be identical.\n');rad = -4;return;
%         v2n=[0;0;0];
%     else
%         v2n = v2/l2;
%     end
%     
%     % nv describes the normal vector on the plane of the circle
%     nv(:,i) = cross(v1n,v2n)/norm(cross(v1n,v2n));
%     if find(sum(abs(nv(:,i)),2)<1e-5),
%         %fprintf('??? Warning using ==> cirlefit3d\nSome corresponding input points are nearly collinear.\n');
%         counter1=counter1+1;
%     end
%     
%     
%     %Any point on the plane is a linear combination of v1n and v2nb
%     [vec(:,i), resnorm(:,i),residual(:,i),exitflag(i),output]=lsqnonlin(@(x)minimizeError(p1,p2,p3,v1n,v2n,r,x),ig,[],[],options);
% %     %centre(:,i)=lsqnonlin(@(x)minimizeError(p1,p2,p3,v1n,v2nb,r,x),[1;1],[],[],options)
%     ig=vec(:,i);
%     centre(:,i)=p1+vec(1,i)*v1n+vec(2,i)*v2n; 
%     if exitflag(i)<=0
%             display('Did not find solution');
%             points=[points;i];
%     end
%     rad(i)=sqrt(mean([(norm(centre(:,i)-p1))^2;(norm(centre(:,i)-p2))^2;(norm(centre(:,i)-p3))^2]));

    end
    
    
end
%center=[smooth(centre(1,:),0.1,'rloess').';smooth(centre(2,:),0.1,'rloess').';smooth(centre(3,:),0.1,'rloess').'];
center2=[smooth(centre(1,:),0.1,'loess').';smooth(centre(2,:),0.1,'loess').';smooth(centre(3,:),0.1,'loess').'];
%center2=centre;
nv2=[smooth(nv(1,:),0.1,'loess').';smooth(nv(2,:),0.1,'loess').';smooth(nv(3,:),0.1,'loess').'];

%% Filtering and obtaining data corresponding to deburring alone
segmentedData=[];
rowno=1;
colno=1;
gap=[];
i=1;
while i<length(rad)
    gap=[];
    if (rad(i)-r)^2<0.001 && max(abs([Fx(i);Fy(i);Fz(i)]))>0.5
        segmentedData(rowno,colno)=i;
        colno=colno+1;
    else
        while i<length(rad) && ((rad(i)-r)^2>0.001 || max(abs([Fx(i);Fy(i);Fz(i)]))<0.5)
            gap=[gap,i];
            i=i+1;
        end
        if length(gap)>4
            rowno=rowno+1;
            colno=1;
        else
            segmentedData(rowno,colno:colno+length(gap)-1)=gap;
            colno=colno+length(gap);
        end
    end
    i=i+1;
    
    
end

[m,n]=size(segmentedData);
for i=1:m
    if segmentedData(i,n)~=0
        segmentDeburring=i;
    end
end
% 
% debCenter=cell(m,max(segmentLengths));%cell for storing center vectors
% debEnd=cell(m,max(segmentLengths));%cell for storing end of tool
for i=1:length(segmentedData(segmentDeburring,:))        
    debCenter(:,i)=center2(:,segmentedData(segmentDeburring,i));
    debRad(i)=rad(segmentedData(segmentDeburring,i));
    debEnd(:,i)=(debCenter(:,i)+sign*53.49*10^-3*nv2(:,segmentedData(segmentDeburring,i)));
    debNormal(:,i)=nv2(:,segmentedData(segmentDeburring,i));
    debFx(i)=Fx(segmentedData(segmentDeburring,i));
    debFy(i)=Fy(segmentedData(segmentDeburring,i));
    debFz(i)=Fz(segmentedData(segmentDeburring,i));
    debX1(i)=x1(segmentedData(segmentDeburring,i));
    debY1(i)=y1(segmentedData(segmentDeburring,i));
    debZ1(i)=z1(segmentedData(segmentDeburring,i));
    debX2(i)=x2(segmentedData(segmentDeburring,i));
    debY2(i)=y2(segmentedData(segmentDeburring,i));
    debZ2(i)=z2(segmentedData(segmentDeburring,i));
    debX3(i)=x3(segmentedData(segmentDeburring,i));
    debY3(i)=y2(segmentedData(segmentDeburring,i));
    debZ3(i)=z3(segmentedData(segmentDeburring,i));
    if i==1
        t1=(dot((debEnd(:,i)-linept1),(linept2-linept1))/dot((linept1-linept2),(linept1-linept2)));
        Q=linept1+t1*(linept2-linept1);
        d1=norm(Q-debEnd(:,i));
        
        sign=sign*-1;
        debEnd2=(debCenter(:,i)+sign*53.49*10^-3*nv2(:,segmentedData(segmentDeburring,i)));
        t2=(dot((debEnd2(:,i)-linept1),(linept2-linept1))/dot((linept1-linept2),(linept1-linept2)));
        Q=linept1+t2*(linept2-linept1);
        d2=norm(Q-debEnd2(:,i));
        
%         d1
%         d2
%         t1
%         t2
        %projection at end assuming flipped sign
%         debEnd3=(debCenter(:,end)+sign*53.49*10^-3*nv2(:,segmentedData(segmentDeburring,end)));
%         t3=(dot((debEnd2(:,end)-linept1),(linept2-linept1))/dot((linept1-linept2),(linept1-linept2)));
            %switch sign again if the t value is greater than 1.3 or less
            %than -0.2
        if d1<d2 %|| abs(t3-t2)<0.6
            display('Here');
            sign=sign*-1;
            %sign switched to original
        else
            debEnd(:,i)=(debCenter(:,i)+sign*53.49*10^-3*nv2(:,segmentedData(segmentDeburring,i)));
        end

        
    end
end
 

%% Project onto line paramterized in terms of 't'
v.FrameRate=15;
open(v);
a=figure();
[m,n]=size(debCenter);
for i=1:length(debRad)
    pts=[debCenter(:,i).';debEnd(:,i).'];
    pts3=debEnd(:,i).';
    pts2=[A.';B.';D.';C.';A.'];
    pts4=[G.';E.';F.';H.';G.'];
    pts5=[E.';A.';C.';G.';E.'];
    pts6=[F.';B.';D.';H.';F.'];
    figure(a);
    plot3(pts(:,1), pts(:,2), pts(:,3));
    hold on;
    %plot3(pts4(:,1), pts4(:,2), pts4(:,3));
    fill3(pts2(:,1),pts2(:,2),pts2(:,3),'g');
    fill3(pts4(:,1),pts4(:,2),pts4(:,3),'g');
    fill3(pts5(:,1),pts5(:,2),pts5(:,3),'g');
    fill3(pts6(:,1),pts6(:,2),pts6(:,3),'g');
    plot3(pts3(:,1),pts3(:,2),pts3(:,3),'b*');
%     plot3(debX1(i),debY1(i),debZ1(i),'r*');
%     plot3(debX2(i),debY2(i),debZ2(i),'r*');
%     plot3(debX3(i),debY3(i),debZ3(i),'r*');
    pts7=[debX1(i), debY1(i),debZ1(i);debX2(i),debY2(i),debZ2(i);debX3(i),debY3(i),debZ3(i)];
    
%     fill3(pts7(:,1),pts7(:,2),pts7(:,3),'r');
    points=getCircle3DPoints(debEnd(:,i).',debNormal(:,i).',0.02);
    plot3(points(1,:),points(2,:),points(3,:),'r-');
    plot3(debCenter(1,i),debCenter(2,i),debCenter(3,i),'g*');
    text(A(1),A(2),A(3),'A');
    text(B(1),B(2),B(3),'B');
    text(C(1),C(2),C(3),'C');
    text(D(1),D(2),D(3),'D');
    text(E(1),E(2),E(3),'E');
    text(F(1),F(2),F(3),'F');
    text(G(1),G(2),G(3),'G');
    text(H(1),H(2),H(3),'H');
    %axis([0.1 0.4 -0.25 0 -0.25 0.5]);
    axis('equal');
    pause(0.05);
    frame=getframe;
    writeVideo(v,frame);
    hold off;
    
    
end
close(v);

%debEnd2=cell2mat(debEnd);

%% Start the projection onto parametrized line
% Insert if conditions to choose line coordinates depending on the edge
% number in filename

line=[linept1,linept2];
[m,n]=size(debEnd);

paired=[];
for i=1:n
%     res=projPointOnLine(debEnd2(:,i),line);
%     dist=norm(res-debEnd2(:,i));
%     if dist<0.25
%         %find parameter t
%         % x= x0+(xf-x0)t
%         t=(res(1)-linept1(1))/(linept2(1)-linept1(1));
%         paired=[paired; i, t, dist];
%     end
    t(i)=(dot((debEnd(:,i)-linept1),(linept2-linept1))/dot((linept1-linept2),(linept1-linept2)));
    Q=linept1+t(i)*(linept2-linept1);
    %res-Q
    d(i)=norm(Q-debEnd(:,i));
end

figure()
plot(d,'DisplayName','distance')
hold on
plot(debFx,'DisplayName','Fx')
plot(t,'DisplayName','parameter t')
legend('show');