function [st0,st1,tsq] = calcX2B(final,input)

u = input(1); am = input(2); vm = input(3);

x2 = final(1);
v2 = final(2);
a2 = final(3);

t21 = (-a2 + sqrt(a2^2+2*u*(v2-vm)))/u;
t22 = (-a2 - sqrt(a2^2+2*u*(v2-vm)))/u;

if abs(a2 + t21*u) <= abs(am) && abs(abs(v2-a2*t21-(t21^2*u)/2)-abs(vm)) < 1e-4 && t21 > 0 % case 1
    t1 = 0;
    t2 = t21;
elseif abs(a2 + t22*u) <= abs(am) && abs(abs(v2-a2*t22-(t22^2*u)/2)-abs(vm)) < 1e-4 && t22 > 0 % case 1
    t1 = 0;
    t2 = t22;
else % case 2
    t1 = (a2^2 - am^2 + 2*u*v2 - 2*u*vm)/(2*am*u);
    t2 = (am-a2)/u;    
end
    
a1 = a2 + t2*u;
a0 = a1;

v1 = v2 - a1*t2 + 1/2*u*t2^2;
v0 = v1 - a0*t1;

x1 = x2 - v1*t2 - 1/2*a1*t2^2 + 1/6*u*t2^3;
x0 = x1 - v0*t1 - 1/2*a0*t1^2;
    

st0 = [x0 v0 a0];
st1 = [x1 v1 a1];
tsq = [t1 t2];

end