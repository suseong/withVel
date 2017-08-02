function [frontStates,tsq,isq] = backPart2(init,final,input)

xf = final(1); vf = final(2); af = final(3);
u = input(1); am = input(2); vm = input(3);

pu_ =  1/(2*u)*af^2 + vm - 1/u*am^2;
pd_ = -1/(2*u)*af^2 + vm;
mu_ =  1/(2*u)*af^2 - vm;
md_ = -1/(2*u)*af^2 - vm + 1/u*am^2;

% plot(init(2),init(3),'*')

if vf >= pu_ && af >= am  
    disp('region 6')
    t1 = (vf-pu_)/am;
    t2 = (af-am)/u;
    tsq = [t1 t2]; isq = [0 u];
elseif vf >= pd_ &&  af < am   
    disp('region 5')
    t1 = (vf-pd_)/am;
    t2 = (am-af)/u;
    tsq = [t1 t2]; isq = [0 -u];
elseif vf >= mu_ && vf < pu_ && af >= am
    disp('region 1')
    t2 = (af-am)/u;
    tsq = [0 t2]; isq = [0 u];
elseif vf >= mu_ && vf < pd_ && af < am && af >= -am
%     disp('safe region')
    tsq = [0 0]; isq = [0 0];
elseif vf >= md_ && vf < pd_ && af < -am
    disp('region 2')
    t2 = (-am-af)/u;
    tsq = [0 t2]; isq = [0 -u];
elseif vf < mu_ && af >= -am
    disp('region 3')
    t1 = (mu_-vf)/am;
    t2 = (af+am)/u;
    tsq = [t1 t2]; isq = [0 u];
elseif vf < md_ && af < -am
    disp('region 4')
    t1 = (md_-vf)/am;
    t2 = (-am-af)/u;
    tsq = [t1 t2]; isq = [0 -u];
else
    disp('wrong')
    keyboard
end

u1 = isq(1); u2 = isq(2);
t1 = tsq(1); t2 = tsq(2);

a2 = af - u2*t2;
v2 = vf - a2*t2 - 1/2*u2*t2^2;
x2 = xf - v2*t2 - 1/2*a2*t2^2 - 1/6*u2*t2^3;

a1 = a2 - u1*t1;
v1 = v2 - a1*t1 - 1/2*u1*t1^2;
x1 = x2 - v1*t1 - 1/2*a1*t1^2 - 1/6*u1*t1^3;
 
frontStates{1} = [x1 v1 a1];
frontStates{2} = [x2 v2 a2];
frontStates{3} = final;

end