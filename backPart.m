function [frontStates,tsq_,inpsq_] = backPart(init,final,input)

u = input(1); am = input(2); vm = input(3);

p0 = init(1); pf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

if af > am
    inpf = u;
    tf = (af-am)/u;
    a2 = af - u*tf;
    v2 = vf - a2*tf - 1/2*u*tf^2;
    p2 = pf - v2*tf - 1/2*a2*tf^2 - 1/6*u*tf^3;
elseif af < -am
    inpf = -u;
    tf = (-am-af)/u;
    a2 = af + u*tf;
    v2 = vf - a2*tf + 1/2*u*tf^2;
    p2 = pf - v2*tf - 1/2*a2*tf^2 + 1/6*u*tf^3;
else
    inpf = 0;
    tf = 0;
    a2 = af;
    v2 = vf;
    p2 = pf;
end

st2 = [p2 v2 a2];
cnt = 0;

vm_ = vm;

while 1
    cnt = cnt + 1;
    if v2 > vm && vm > 0
        [st0,st1,tsq] = calcX2B(st2,[u am vm]);
        inp01 = [0 -u];
    elseif v2 < -vm && vm > 0
        [st0,st1,tsq] = calcX2B(st2,-[u am vm]);
        inp01 = [0 u];
    else
        st0 = st2; st1 = st2;
        tsq = [0 0];
        inp01 = [0 0];
    end
    
    a0 = st0(3); v0 = st0(2);
    t_ = abs(a0/u);
    
    if v0 > 0 && a0 < 0 && v0 + 1/2*u*t_^2 >= vm_
        vm = vm - 0.01;
    elseif v0 < 0 && a0 > 0 && v0 - 1/2*u*t_^2 <= -vm_
        vm = vm - 0.01;
    elseif vm < 0.01
        disp('wrong')
        keyboard
%     elseif cnt > 50
%         keyboard
    else
        break;
    end
end

% if tsq(2) > 0
%     t1 = tsq(2); t0 = tsq(1); u1 = inp01(2); u0 = inp01(1);
%     a1 = a2 - u1*t1; v1 = v2 - a1*t1 - 1/2*u1*t1^2;
%     a0 = a1 - u0*t0; v0 = v1 - a0*t0 - 1/2*u0*t0^2;
%    if abs(v1) < vm_
%        t11 = (-a1 + sqrt(a1^2-2*u1*(v1-vm_+0.1)))/u1;
%        t12 = (-a1 - sqrt(a1^2-2*u1*(v1-vm_+0.1)))/u1;
% %        t1 = max(t11,t12);
%         t1 = a2/u1;
%        tsq = [0 tsq(2)-a2/u1];
%        t1 = tsq(1); t2 = tsq(2);
%    elseif abs(v0) < vm_
%        t01 = (-a0 + sqrt(a0^2-2*u0*(v0-vm_)))/u0;
%        t02 = (-a0 + sqrt(a0^2-2*u0*(v0-vm_)))/u0;
%        t0 = max(t01,t02);
%        tsq = [tsq(1)-t0 tsq(2)];
%        t1 = tsq(1); t2 = tsq(2);       
%    end
%    
%    a1 = af - t2*u1;
%    a0 = a1;
%    v1 = vf - a1*t2 - 1/2*u1*t2^2;
%    v0 = v1 - a0*t1;
%    p1 = pf - v1*t2 - 1/2*a1*t2^2 - 1/6*u1*t2^3;
%    p0 = p1 - v0*t1 - 1/2*a0*t1^2;
%    
%    st0 = [p0 v0 a0];
%    st1 = [p1 v1 a1];
% end

frontStates{1} = st0;
frontStates{2} = st1;
frontStates{3} = st2;

tsq_ = [tsq tf];
inpsq_ = [inp01 inpf];

end