function [tsq,err] = calcX7_11(init,final,input,t5)

% case 11    ___
%           /   \       1 2 3 4 5 6 7
%                \/

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

% t6 = 0;
% t4 = 0;
% t3 = am/u;
% t1 = (am-a0)/u;
% t7 = (af + t5*u)/u;
% t2 = (2*t5^2*u^2 - 2*u*v0 + 2*u*vf + a0^2 - af^2 - 2*am^2)/(2*am*u);
% 
% err_ = (12*t5^4*u^4 - 12*u^2*v0^2 + 12*u^2*vf^2 + 8*a0^3*am - 8*af^3*am - 3*a0^4 + 3*af^4 - 6*a0^2*am^2 - 6*af^2*am^2 + 12*a0^2*u*v0 + 12*am^2*u*v0 - 12*af^2*u*vf + 12*am^2*u*vf + 24*am*u^2*x0 - 24*am*u^2*xf + 24*am*t5^3*u^3 + 24*t5^2*u^3*vf - 12*af^2*t5^2*u^2 + 12*am^2*t5^2*u^2 - 24*a0*am*u*v0 + 24*af*am*u*vf - 24*af^2*am*t5*u + 48*am*t5*u^2*vf)/(24*am*u^2);
% tsq_ = [t1 t2 t3 t4 t5 t6 t7];
% 
% v3 = (- a0^2 + 2*am^2 + 2*t2*u*am + 2*u*v0)/(2*u);
% 
% % if or(min(tsq_) < -1e-3, abs(v3) > abs(vm))
% %     tsq = [0 0 0 0 0 0 0];
% %     err = -100;
% % else
%     tsq = tsq_;
%     err = err_;
% % end

t1 = (am-a0)/u;
t4 = 0;
t3 = (am - af + t5*u)/u;
t2 = (2*t5^2*u^2 - 2*u*v0 + 2*u*vf + a0^2 + af^2 - 2*am^2 - 4*af*t5*u)/(2*am*u);

err = (12*t5^4*u^4 - 12*u^2*v0^2 + 12*u^2*vf^2 + 8*a0^3*am - 8*af^3*am - 3*a0^4 + 3*af^4 - 6*a0^2*am^2 + 6*af^2*am^2 - 24*af^3*t5*u + 12*a0^2*u*v0 + 12*am^2*u*v0 + 12*af^2*u*vf + 12*am^2*u*vf + 24*am*u^2*x0 - 24*am*u^2*xf - 48*af*t5^3*u^3 + 24*am*t5^3*u^3 + 24*t5^2*u^3*vf + 60*af^2*t5^2*u^2 + 12*am^2*t5^2*u^2 - 24*a0*am*u*v0 - 24*af*am*u*vf - 24*af*am^2*t5*u + 48*af^2*am*t5*u - 48*af*t5*u^2*vf + 48*am*t5*u^2*vf - 72*af*am*t5^2*u^2)/(24*am*u^2);
tsq = [t1 t2 t3 0 0 t4 t5];

end