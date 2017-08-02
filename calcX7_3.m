function tsq = calcX7_3(init,final,input)

% case 3     ___
%           /   \__         1 2 3 5 6 7
%                  \/

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

t5sqr = (-2*u*vf + af^2 + 2*vm*u)/(2*u^2);

if t5sqr < 0
    tsq = [0 0 0 0 0 0 0];
else
    t5 = sqrt(t5sqr);
    t6 = 0;
    t3 = am/u;
    t1 =(am-a0)/u;
    t2 = -(- a0^2 + 2*am^2 + 2*u*v0 - 2*u*vm)/(2*am*u);
    t7 = (af + t5*u)/u;
    t4 = -(12*u^2*vm^2 - 12*u^2*v0^2 + 8*a0^3*am + 4*af^3*am - 3*a0^4 - 6*a0^2*am^2 + 12*a0^2*u*v0 + 12*am^2*u*v0 + 12*am^2*u*vm + 24*am*u^2*x0 - 24*am*u^2*xf - 24*am*t5^3*u^3 - 24*a0*am*u*v0 + 24*af*am*u*vm + 48*am*t5*u^2*vm - 24*af*am*t5^2*u^2)/(24*am*u^2*vm);
    tsq_ = [t1 t2 t3 t4 t5 t6 t7];
    if min(tsq_) < -1e-3
        tsq = [0 0 0 0 0 0 0];
    else
        tsq = tsq_;
    end
end

end
