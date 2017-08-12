function [frontStates,tsq,isq] = backPart3(init,final,input)

xf = final(1); vf = final(2); af = final(3);
u = input(1); am = input(2); vm = input(3);

% plot(final(2),final(3),'*')

pu =  1/(2*u)*af.^2 + vm - 1/u*am^2;
pd = -1/(2*u)*af.^2 + vm;
mu =  1/(2*u)*af.^2 - vm;
md = -1/(2*u)*af.^2 - vm + 1/u*am^2;

ppu =  1/(2*u)*af.^2 + vm;
ppd = -1/(2*u)*af.^2 + vm + 1/u*am^2;
mmu =  1/(2*u)*af.^2 - vm - 1/u*am^2;
mmd = -1/(2*u)*af.^2 - vm;

if vf < mmu && af >= -am
%     disp('region 1')
    t1 = am/u; t2 = (mmu-vf)/am; t3 = (af+am)/u;
    tsq = [t1 t2 t3]; isq = [-u 0 u];
    
elseif vf < mmd && af < -am
%     disp('region 2')
    t1 = am/u; t2 = (mmd-vf)/am; t3 = (-am-af)/u;
    tsq = [t1 t2 t3]; isq = [-u 0 -u];
    
elseif vf >= mmu && vf < mu && af >= 0
%     disp('region 3')
    a_ = -sqrt(u*(-vm-vf+1/2/u*af^2));
    t1 = -a_/u; t2 = (af-a_)/u;
    tsq = [t1 t2 0]; isq = [-u u 0];

elseif vf >= mmu && vf < mmd && af < 0
%     disp('region 3')
    a_ = -sqrt(u*(-vm-vf+1/2/u*af^2));
    t1 = -a_/u; t2 = (af-a_)/u;
    tsq = [t1 t2 0]; isq = [-u u 0];    

elseif vf < md && vf >= mmd && vf < mu
%     disp('region 4')
    a_ = -sqrt(u*(vm+vf+1/2/u*af^2));
    t1 = (a_-af)/u;
    tsq = [t1 0 0]; isq = [-u 0 0];
        
elseif vf < pu && vf >= mu && af >= am
%     disp('region 5')
    t1 = (af-am)/u;
    tsq = [t1 0 0]; isq = [u 0 0];
    
elseif vf >= mu && vf < pd && af < am && af >= -am
%     disp('region 6')
    tsq = [0 0 0]; isq = [0 0 0];
    
elseif vf >= md && vf < pd && af < -am
%     disp('region 7')
    t1 = (-am-af)/u;
    tsq = [t1 0 0]; isq = [-u 0 0];    
    
elseif vf < ppu && vf >= pu && vf >= pd && af > 0
%     disp('region 8')
    a_ = sqrt(u*(vm-vf+1/2/u*af^2));
    t1 = (af-a_)/u;
    tsq = [t1 0 0]; isq = [u 0 0];
        
elseif vf >= ppu && vf < ppd && af >= 0
%     disp('region 9')
    a_ = sqrt(u*(vf-vm+1/2/u*af^2));
    t1 = a_/u; t2 = (a_-af)/u;
    tsq = [t1 t2 0]; isq = [u -u 0];

elseif vf >= pd && vf < ppd && af < 0
%     disp('region 9')
    a_ = sqrt(u*(vf-vm+1/2/u*af^2));
    t1 = a_/u; t2 = (a_-af)/u;
    tsq = [t1 t2 0]; isq = [u -u 0];

elseif vf >= ppu && af >= am
%     disp('region 10')
    t1 = am/u; t2 = (vf-ppu)/am; t3 = (af-am)/u;
    tsq = [t1 t2 t3]; isq = [u 0 u];
    
elseif vf >= ppd && af < am
%     disp('region 11')
    t1 = am/u; t2 = (vf-ppd)/am; t3 = (am-af)/u;
    tsq = [t1 t2 t3]; isq = [u 0 -u];
    
else
    disp('wrong')
    keyboard
end

u1 = isq(1); u2 = isq(2); u3 = isq(3);
t1 = tsq(1); t2 = tsq(2); t3 = tsq(3);

a3 = af - u3*t3;
v3 = vf - a3*t3 - 1/2*u3*t3^2;
x3 = xf - v3*t3 - 1/2*a3*t3^2 - 1/6*u3*t3^3;

a2 = a3 - u2*t2;
v2 = v3 - a2*t2 - 1/2*u2*t2^2;
x2 = x3 - v2*t2 - 1/2*a2*t2^2 - 1/6*u2*t2^3;

a1 = a2 - u1*t1;
v1 = v2 - a1*t1 - 1/2*u1*t1^2;
x1 = x2 - v1*t1 - 1/2*a1*t1^2 - 1/6*u1*t1^3;
 
frontStates{1} = [x1 v1 a1];
frontStates{2} = [x2 v2 a2];
frontStates{3} = [x3 v3 a3];
frontStates{4} = final;

end