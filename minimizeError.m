function res=minimizeError(p1,p2,p3,v1n,v2nb,r,x)
%% Function to minimize least squares error in radius of the tool mounted with markers
c=p1+x(1)*v1n+x(2)*v2nb;
res=[(norm(c-p1)-r);(norm(c-p2)-r);(norm(c-p3)-r)];