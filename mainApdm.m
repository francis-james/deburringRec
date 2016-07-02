clear all;
apdm_matrix = dlmread('data/obj1_sub1_edge1_pass1_apdm.csv',',',1,1);
vec=[0;0;-1];
[m,n]=size(apdm_matrix);
for i=1:m
    q=apdm_matrix(i,27:30).';
    res=quartMult(quartMult(q,[0;vec]),[q(1),-q(2),-q(3),-q(4)]);
    vnew(:,i)=res(2:4);
end

for i=1:m
    pts=[0,0,0;vnew(:,i).'];
    plot3(pts(:,1),pts(:,2),pts(:,3));
    pause(0.05);
    drawnow;
end