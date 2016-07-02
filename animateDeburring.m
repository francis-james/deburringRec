function animateDeburring(debFx,debFy,debFz,t, debCenter, debRad, debEnd, debX1, debY1, debZ1, ...
    debX2, debY2, debZ2, debX3, debY3, debZ3, A,B,C,D,E,F,G,H)
figure()
[m,n]=size(debCenter);
for i=1:length(debRad)
    pts=[debCenter(:,i).';debEnd(:,i).'];
    pts3=debEnd(:,i).';
    pts2=[A.';B.';D.';C.';A.'];
    pts4=[G.';E.';F.';H.';G.'];
    pts5=[E.';A.';C.';G.';E.'];
    pts6=[F.';B.';D.';H.';F.'];
    plot3(pts(:,1), pts(:,2), pts(:,3));
    hold on;
    %plot3(pts4(:,1), pts4(:,2), pts4(:,3));
    fill3(pts2(:,1),pts2(:,2),pts2(:,3),'g');
    fill3(pts4(:,1),pts4(:,2),pts4(:,3),'g');
    fill3(pts5(:,1),pts5(:,2),pts5(:,3),'g');
    fill3(pts6(:,1),pts6(:,2),pts6(:,3),'g');
    plot3(pts3(:,1),pts3(:,2),pts3(:,3),'b*');
    plot3(debX1(i),debY1(i),debZ1(i),'r*');
    plot3(debX2(i),debY2(i),debZ2(i),'r*');
    plot3(debX3(i),debY3(i),debZ3(i),'r*');
    pts7=[debX1(i), debY1(i),debZ1(i);debX2(i),debY2(i),debZ2(i);debX3(i),debY3(i),debZ3(i)];
    fill3(pts7(:,1),pts7(:,2),pts7(:,3),'r');
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
    hold off;
    
    
end
