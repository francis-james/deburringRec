function res=minimizeError(p1,p2,c,r)
%% Function to minimize least squares error in radius of the tool mounted with markers
res=[(norm(c-p1)-r);(norm(c-p2)-r)];