function tsq = calcX7_8(init,final,input)

% case 8
%          /\___/\
%

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);
t5sqr = (2*u*vf + a0^2 + af^2 - 2*t3sqr*u^2 - 2*v0*u)/(2*u^2);

if or(t3sqr < 0, t5sqr < 0)
    tsq = [0 0 0 0 0 0 0];
else
    t3 = sqrt(t3sqr);
    t5 = sqrt(t5sqr);
    t2 = 0;
    t6 = 0;
    t1 = -(a0 - t3*u)/u;
    t7 = -(af - t5*u)/u;
    t4 = -(6*t3^3*u^3 + 6*t5^3*u^3 + 3*a0^2*af + 6*u^2*x0 - 6*u^2*xf + 2*a0^3 + af^3 - 6*a0^2*t3*u - 6*a0^2*t5*u + 12*t3*u^2*v0 + 12*t5*u^2*v0 - 6*af*t3^2*u^2 - 6*af*t5^2*u^2 + 12*t3^2*t5*u^3 - 6*a0*u*v0 - 6*af*u*v0)/(3*u*(- a0^2 + 2*t3^2*u^2 + 2*v0*u));
   
    tsq_ = [t1 t2 t3 t4 t5 t6 t7];
    if min(tsq_) < -1e-3
        tsq = [0 0 0 0 0 0 0];
    else
        tsq = tsq_;
    end
end

end