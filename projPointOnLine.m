function [res]=projPointOnLine(pt,line)
%% Form
%pt= [[x1;y1],[x2,y2]] ->columns are points
% line= [pt1,pt2]; each point is a col
P=pt;
A=line(:,1);
B=line(:,2);
AD=A+dot((P-A),(B-A))/(norm(B-A))^2*(B-A);
res=AD;

