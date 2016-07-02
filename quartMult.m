function res=quartMult(v1,v2)
a1=v1(1);
b1=v1(2);
c1=v1(3);
d1=v1(4);

a2=v2(1);
b2=v2(2);
c2=v2(3);
d2=v2(4);

res=[a1*a2-b1*b2-c1*c2-d1*d2; ...
    a1*b2+b1*a2+c1*d2-d1*c2; ...
    a1*c2-b1*d2+c1*a2+d1*b2; ...
    a1*d2+b1*c2-c1*b2+d1*a2];
    
