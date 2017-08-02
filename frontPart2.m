function [frontStates,tsq,isq] = frontPart2(init,final,input)

x0 = init(1); v0 = init(2); a0 = init(3);
u = input(1); am = input(2); vm = input(3);

pu_ =  1/(2*u)*a0^2 + vm - 1/u*am^2;
pd_ = -1/(2*u)*a0^2 + vm;
mu_ =  1/(2*u)*a0^2 - vm;
md_ = -1/(2*u)*a0^2 - vm + 1/u*am^2;

% plot(init(2),init(3),'*')

if v0 >= pd_ && a0 >= -am  
%     disp('region 6')
    dv = v0 - pd_;
    t0 = (a0 + am)/u;
    t1 = dv/am;
    tsq = [t0 t1]; isq = [-u 0];
elseif v0 >= pu_ &&  a0 < -am   
%     disp('region 5')
    dv = v0 - pu_;
    t0 = (-am-a0)/u;
    t1 = dv/am;
    tsq = [t0 t1]; isq = [u 0];
elseif v0 >= md_ && v0 < pd_ && a0 >= am
%     disp('region 1')
    t0 = (a0-am)/u;
    tsq = [t0 0]; isq = [-u 0];
elseif v0 >= mu_ && v0 < pd_ && a0 < am && a0 >= -am
%     disp('safe region')
    tsq = [0 0]; isq = [0 0];
elseif v0 >= mu_ && v0 < pu_ && a0 < -am
%     disp('region 2')
    t0 = (-a0-am)/u;
    tsq = [t0 0]; isq = [u 0];
elseif v0 < md_ && a0 >= am
%     disp('region 3')
    dv = md_-v0;
    t0 = (a0-am)/u;
    t1 = dv/am;
    tsq = [t0 t1]; isq = [-u 0];
elseif v0 < mu_ && a0 < am
%     disp('region 4')
    dv = mu_-v0;
    t0 = (am-a0)/u;
    t1 = dv/am;
    tsq = [t0 t1]; isq = [u 0];
else
    disp('wrong')
    keyboard
end

u1 = isq(1); u2 = isq(2);
t1 = tsq(1); t2 = tsq(2);

a1 = a0 + u1*t1;
v1 = v0 + a0*t1 + 1/2*u1*t1^2;
x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u1*t1^3;

a2 = a1 + u2*t2;
v2 = v1 + a1*t2 + 1/2*u2*t2^2;
x2 = x1 + v1*t2 + 1/2*a1*t2^2 + 1/6*u2*t2^3;


frontStates{1} = init;
frontStates{2} = [x1 v1 a1];
frontStates{3} = [x2 v2 a2];

end