function [tsq,err] = calcX7_12(init,final,input,t3)

% case 12    
%           /\         1 2 3 4 5 6 7
%             \/

u = input(1); am = input(2); vm = input(3);

x0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

% t3sqr = (2*u*vf + a0^2 + af^2 - 4*af*t7*u + 2*t7^2*u^2 - 2*v0*u )/(2*u^2);
% 
% % if t3sqr < 0
% %     tsq = [0 0 0 0 0 0 0];
% %     err = -100;
% % else
%     t3 = sqrt(t3sqr);
%     t2 = 0;
%     t4 = 0;
%     t6 = 0;
%     t1 = -(a0 - t3*u)/u;
%     t5 = -(af - t7*u)/u;
%     err_ = (6*t3^3*u^3 - 6*t7^3*u^3 + 3*a0^2*af + 6*u^2*x0 - 6*u^2*xf + 2*a0^3 + af^3 - 6*a0^2*t3*u - 6*a0^2*t7*u - 6*af^2*t7*u + 12*t3*u^2*v0 + 12*t7*u^2*v0 - 6*af*t3^2*u^2 + 12*af*t7^2*u^2 + 12*t3^2*t7*u^3 - 6*a0*u*v0 - 6*af*u*v0)/(6*u^2);
% 
%     tsq_ = [t1 t2 t3 t4 t5 t6 t7];
%     
%     v3 = v0 + a0*t1 + (t1^2*u)/2 - (t3^2*u)/2 + t3*(a0 + t1*u);
%     
% %     if or(min(tsq_) < -1e-3, abs(v3) > abs(vm))
% %         tsq = [0 0 0 0 0 0 0];
% %         err = -100;
% %     else
%         tsq = real(tsq_);
%         err = real(err_);
% %     end
% % end

t2 = 0;
t4 = 0;
t5 = (2*t3^2*u^2 + 2*u*v0 - 2*u*vf - a0^2 + af^2 + 4*af*t3*u)/(4*t3*u^2);
t1 = -(a0 - af - t3*u + t5*u)/u;

err = x0 - xf - (a0 - af - t3*u + t5*u)^3/(6*u^2) - (t3^3*u)/6 + t3^2*(af/2 + (t3*u)/2 - (t5*u)/2) + (a0*(a0 - af - t3*u + t5*u)^2)/(2*u^2) + (t3*(- a0^2 + af^2 + 2*af*t3*u - 2*af*t5*u + t3^2*u^2 - 2*t3*t5*u^2 + t5^2*u^2 + 2*v0*u))/(2*u) - (v0*(a0 - af - t3*u + t5*u))/u + (2*t3^2*u^2 + 2*u*v0 - 2*u*vf - a0^2 + af^2 + 4*af*t3*u)^3/(384*t3^3*u^5) + ((af/2 - (t5*u)/2)*(2*t3^2*u^2 + 2*u*v0 - 2*u*vf - a0^2 + af^2 + 4*af*t3*u)^2)/(16*t3^2*u^4) + ((2*t3^2*u^2 + 2*u*v0 - 2*u*vf - a0^2 + af^2 + 4*af*t3*u)*(- a0^2 + af^2 + 4*af*t3*u - 2*af*t5*u + 2*t3^2*u^2 - 4*t3*t5*u^2 + t5^2*u^2 + 2*v0*u))/(8*t3*u^3);
tsq = [t1 t2 t3 0 0 t4 t5];

end