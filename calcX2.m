function [st1,st2,tsq] = calcX2(init,input)

u = input(1); am = input(2); vm = input(3);

x0 = init(1);
v0 = init(2);
a0 = init(3);

t11 = (-a0 + sqrt(a0^2-2*u*(v0+vm)))/u;
t12 = (-a0 - sqrt(a0^2-2*u*(v0+vm)))/u;

if abs(a0 + t11*u) <= abs(am) && abs(abs(v0 + a0*t11+1/2*u*t11^2)-abs(vm)) < 1e-4 && t11 > 0 % case 1
    t1 = t11;
    t2 = 0;
elseif abs(a0 + t12*u) <= abs(am) && abs(abs(v0 + a0*t12+1/2*u*t12^2)-abs(vm)) < 1e-4&& t12 > 0 % case 1
    t1 = t12;
    t2 = 0;
else % case 2
    t1 = -(a0 - am)/u;
    t2 = -(- a0^2 + am^2 + 2*u*v0 + 2*u*vm)/(2*am*u);    
end

a1 = a0 + t1*u;
a2 = a1;

v1 = v0 + a0*t1 + 1/2*u*t1^2;
v2 = v1 + a1*t2;

x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
x2 = x1 + v1*t2 + 1/2*a1*t2^2;

st1 = [x1 v1 a1];
st2 = [x2 v2 a2];
tsq = [t1 t2];

end