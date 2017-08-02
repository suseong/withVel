function [frontStates,tsq,isq] = frontPart3(init,final,input)

x0 = init(1); v0 = init(2); a0 = init(3);
u = input(1); am = input(2); vm = input(3);

% plot(init(2),init(3),'*')

pu =  1/(2*u)*a0.^2 + vm - 1/u*am^2;
pd = -1/(2*u)*a0.^2 + vm;
mu =  1/(2*u)*a0.^2 - vm;
md = -1/(2*u)*a0.^2 - vm + 1/u*am^2;

ppu =  1/(2*u)*a0.^2 + vm;
ppd = -1/(2*u)*a0.^2 + vm + 1/u*am^2;
mmu =  1/(2*u)*a0.^2 - vm - 1/u*am^2;
mmd = -1/(2*u)*a0.^2 - vm;

if v0 < mmd && a0 >= am
%     disp('region 1')
    mmd = -1/(2*u)*am.^2 - vm;
    t1 = (a0-am)/u; 
    v1 = v0+a0*t1-1/2*u*t1^2;
    t2 = (mmd-v1)/am; t3 = am/u;
    tsq = [t1 t2 t3]; isq = [-u 0 -u];
    
elseif v0 < mmu && a0 < am
%     disp('region 2')
    mmu =  1/(2*u)*am.^2 - vm - 1/u*am^2;
    t1 = (am-a0)/u; 
    v1 = v0+a0*t1+1/2*u*t1^2;    
    t2 = (mmu-v1)/am; t3 = am/u;
    tsq = [t1 t2 t3]; isq = [u 0 -u];
    
elseif v0 >= mmd && v0 < md && v0 < mu && a0 >= 0
%     disp('region 3')
    a_ = sqrt(u*(vm+v0+1/2/u*a0^2));
    t1 = (a0-a_)/u; t2 = 0; t3 = 0;
    tsq = [t1 0 0]; isq = [-u 0 0];
    
elseif v0 < mmd && v0 >= mmu && a0 >= 0
%     disp('region 4')
    a_ = sqrt(u*(-v0-vm+1/2/u*a0^2));
    t1 = (a_-a0)/u; t2 = a_/u; t3 = 0;
    tsq = [t1 t2 t3]; isq = [u -u 0];
    
elseif v0 < mu && v0 >= mmu && a0 < 0
%     disp('region 4')    
    a_ = sqrt(u*(-v0-vm+1/2/u*a0^2));
    t1 = (a_-a0)/u; t2 = a_/u; t3 = 0;
    tsq = [t1 t2 t3]; isq = [u -u 0];
    
elseif v0 < pd && v0 >= md && a0 >= am
%     disp('region 5')
    t1 = (a0-am)/u; t2 = 0; t3 = 0;
    tsq = [t1 t2 t3]; isq = [-u 0 0];
    
elseif v0 >= mu && v0 < pd && a0 < am && a0 >= -am
%     disp('region 6')
    tsq = [0 0 0]; isq = [0 0 0];
    
elseif v0 >= mu && v0 < pu && a0 < -am
%     disp('region 7')
    t1 = (-am-a0)/u; t2 = 0; t3 = 0;
    tsq = [t1 t2 t3]; isq = [u 0 0];    
    
elseif v0 < ppd && v0 >= pd && a0 >= 0
%     disp('region 8')
    a_ = -sqrt(u*(-vm+v0+1/2/u*a0^2));
    t1 = (a0-a_)/u; t2 = -a_/u; t3 = 0;
    tsq = [t1 t2 t3]; isq = [-u u 0];
    
elseif v0 < ppd && v0 >= ppu && a0 < 0
%     disp('region 8')
    a_ = -sqrt(u*(-vm+v0+1/2/u*a0^2));
    t1 = (a0-a_)/u; t2 = -a_/u; t3 = 0;
    tsq = [t1 t2 t3]; isq = [-u u 0];    
    
elseif v0 >= pd && v0 >= pu && v0 < ppu && a0 < 0
%     disp('region 9')
    a_ = -sqrt(u*(vm-v0+1/2/u*a0^2));
    t1 = (a_-a0)/u; t2 = 0; t3 = 0;
    tsq = [t1 t2 t3]; isq = [u 0 0];
    
elseif v0 >= ppd && a0 >= -am
%     disp('region 10')
    ppu =  1/(2*u)*am.^2 + vm;
    t1 = (a0+am)/u; 
    v1 = v0+a0*t1-1/2*u*t1^2;
    t2 = (v1-ppu)/am; t3 = am/u;
    tsq = [t1 t2 t3]; isq = [-u 0 u];
    
elseif v0 >= ppu && a0 < -am
%     disp('region 11')
    ppu =  1/(2*u)*am.^2 + vm;
    t1 = (-am-a0)/u; 
    v1 = v0+a0*t1+1/2*u*t1^2;
    t2 = (v1-ppu)/am; t3 = am/u;
    tsq = [t1 t2 t3]; isq = [u 0 u];
    
else
    disp('wrong')
    keyboard
end

u1 = isq(1); u2 = isq(2); u3 = isq(3);
t1 = tsq(1); t2 = tsq(2); t3 = tsq(3);

a1 = a0 + u1*t1;
v1 = v0 + a0*t1 + 1/2*u1*t1^2;
x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u1*t1^3;

a2 = a1 + u2*t2;
v2 = v1 + a1*t2 + 1/2*u2*t2^2;
x2 = x1 + v1*t2 + 1/2*a1*t2^2 + 1/6*u2*t2^3;

a3 = a2 + u3*t3;
v3 = v2 + a2*t3 + 1/2*u3*t3^2;
x3 = x2 + v2*t3 + 1/2*a2*t3^2 + 1/6*u3*t3^3;

frontStates{1} = init;
frontStates{2} = [x1 v1 a1];
frontStates{3} = [x2 v2 a2];
frontStates{4} = [x3 v3 a3];

end