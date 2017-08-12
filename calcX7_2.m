function tsq = calcX7_2(init,final,input)

% case 2
%          /\__          1 2 3 5 6 7 
%              \__/

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

t3sqr = clean((2*u*vm + a0^2 - 2*v0*u)/(2*u^2),1e-4);
if t3sqr < 0
    tsq = [0 0 0 0 0 0 0];
else
    t3 = sqrt(t3sqr);
    t2 = 0; 
    t5 = am/u; 
    t7 = (af+am)/u;
    t1 = -(a0 - t3*u)/u;
    t6 = (2*t3^2*u^2 + 2*u*v0 - 2*u*vf - a0^2 + af^2 - 2*am^2)/(2*am*u);
    t4 = -(12*t3^4*u^4 + 12*u^2*v0^2 - 12*u^2*vf^2 + 8*a0^3*am - 8*af^3*am + 3*a0^4 - 3*af^4 - 6*a0^2*am^2 - 6*af^2*am^2 - 12*a0^2*u*v0 + 12*am^2*u*v0 + 12*af^2*u*vf + 12*am^2*u*vf + 24*am*u^2*x0 - 24*am*u^2*xf + 24*am*t3^3*u^3 + 24*t3^2*u^3*v0 - 12*a0^2*t3^2*u^2 + 12*am^2*t3^2*u^2 - 24*a0*am*u*v0 + 24*af*am*u*vf - 24*a0^2*am*t3*u + 48*am*t3*u^2*v0)/(12*am*u*(- a0^2 + 2*t3^2*u^2 + 2*v0*u));
    tsq_ = [t1 t2 t3 t4 t5 t6 t7];
    if min(tsq_) < -1e-3
        tsq = [0 0 0 0 0 0 0];
    else
        tsq = tsq_;
    end    
end

end
    