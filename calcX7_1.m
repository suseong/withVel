function tsq = calcX7_1(init,final,input)

% case 1    __
%          /  \___                1 3 5 7 2 6 4
%                 \__/     

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

t1 = (am-a0)/u; 
t3 = am/u;
t5 = am/u;
t7 = (af+am)/u;
t2 = -(- a0^2 + 2*am^2 + 2*u*v0 - 2*u*vm)/(2*am*u);
t6 = -(- af^2 + 2*am^2 + 2*u*vf - 2*u*vm)/(2*am*u);
t4 = (12*u^2*v0^2 + 12*u^2*vf^2 - 24*u^2*vm^2 - 8*a0^3*am + 8*af^3*am + 3*a0^4 + 3*af^4 + 6*a0^2*am^2 + 6*af^2*am^2 - 12*a0^2*u*v0 - 12*am^2*u*v0 - 12*af^2*u*vf - 12*am^2*u*vf - 24*am^2*u*vm - 24*am*u^2*x0 + 24*am*u^2*xf + 24*a0*am*u*v0 - 24*af*am*u*vf)/(24*am*u^2*vm);

tsq_ = [t1 t2 t3 t4 t5 t6 t7];

if min(tsq_) < -1e-3
    tsq = [0 0 0 0 0 0 0];
else
    tsq = tsq_;
end

end