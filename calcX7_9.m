function [tsq,err] = calcX7_9(init,final,input,t4)

% case 9    __
%          /  \                1 3 5 7 2 6 4
%              \__/     

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

% t1 = (am-a0)/u; 
% t3 = am/u; 
% t4 = 0;
% t5 = am/u;
% t7 = (af+am)/u;
% t2 = (a0^2 - af^2 - 2*u*v0 + 2*u*vf + 2*am*t6*u)/(2*am*u);
% % t6 = 0;
% 
% err_ = (12*u^2*vf^2 - 12*u^2*v0^2 + 8*a0^3*am - 8*af^3*am - 3*a0^4 + 3*af^4 + 48*am^4 - 6*a0^2*am^2 - 42*af^2*am^2 + 72*am^3*t6*u + 12*a0^2*u*v0 + 12*am^2*u*v0 - 12*af^2*u*vf + 84*am^2*u*vf + 24*am*u^2*x0 - 24*am*u^2*xf + 24*am^2*t6^2*u^2 - 24*a0*am*u*v0 + 24*af*am*u*vf - 24*af^2*am*t6*u + 48*am*t6*u^2*vf)/(24*am*u^2);
% tsq_ = [t1 t2 t3 t4 t5 t6 t7];
% 
% v3 = (- a0^2 + 2*am^2 + 2*t2*u*am + 2*u*v0)/(2*u);
% 
% % if or(min(tsq_) < -1e-3, abs(v3) > abs(vm))
% %     tsq = [0 0 0 0 0 0 0];4
% %     err = -100;
% % else
%     tsq = tsq_;
%     err = err_;
% % end

t1 = (am-a0)/u;
t3 = 2*am/u;
t5 = (af+am)/u;
t2 = (a0^2 - af^2 - 2*u*v0 + 2*u*vf + 2*am*t4*u)/(2*am*u);

err = (12*u^2*vf^2 - 12*u^2*v0^2 + 8*a0^3*am - 8*af^3*am - 3*a0^4 + 3*af^4 + 48*am^4 - 6*a0^2*am^2 - 42*af^2*am^2 + 72*am^3*t4*u + 12*a0^2*u*v0 + 12*am^2*u*v0 - 12*af^2*u*vf + 84*am^2*u*vf + 24*am*u^2*x0 - 24*am*u^2*xf + 24*am^2*t4^2*u^2 - 24*a0*am*u*v0 + 24*af*am*u*vf - 24*af^2*am*t4*u + 48*am*t4*u^2*vf)/(24*am*u^2);
tsq = [t1 t2 t3 0 0 t4 t5];


end