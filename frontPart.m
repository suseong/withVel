function [frontStates,tsq_,inpsq_] = frontPart(init,final,input)

u = input(1); am = input(2); vm = input(3);

p0 = init(1); xf = final(1); 
v0 = init(2); vf = final(2);
a0 = init(3); af = final(3);

if a0 > am
    inp1 = -u;
    t1 = (a0-am)/u;
    a1 = a0 - u*t1;
    v1 = v0 + a0*t1 - 1/2*u*t1^2;
    p1 = p0 + v0*t1 + 1/2*a0*t1^2 - 1/6*u*t1^3;
elseif a0 < -am
    inp1 = u;
    t1 = (-am-a0)/u;
    a1 = a0 + u*t1;
    v1 = v0 + a0*t1 + 1/2*u*t1^2;
    p1 = p0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
else
    inp1 = 0;
    t1 = 0;
    a1 = a0;
    v1 = v0;
    p1 = p0;
end

st1 = [p1 v1 a1];
cnt = 0;
vm_ = vm;

while 1
    cnt = cnt + 1;
    if v1 < -vm
        [st2,st3,tsq] = calcX2(st1,[u am vm]);
        inp23 = [u 0];
    elseif v1 > vm
        [st2,st3,tsq] = calcX2(st1,-[u am vm]);
        inp23 = [-u 0];
    else
        st2 = st1; st3 = st1;
        tsq = [0 0];
        inp23 = [0 0];
    end
    
    a3 = st3(3); v3 = st3(2);
    t_ = abs(a3/u);
    
    if v3 > 0 && a3 > 0 && v3 + a3*t_ - 1/2*u*t_^2 >= vm_
        vm = vm - 0.01;
    elseif v3 < 0 && a3 < 0 && v3 + a3*t_ + 1/2*u*t_^2 <= -vm_
        vm = vm - 0.01;
    elseif vm < 0.01
        disp('wrong')
        keyboard
    else
        break;
    end
end

frontStates{1} = st1;
frontStates{2} = st2;
frontStates{3} = st3;

tsq_ = [t1 tsq];
inpsq_ = [inp1 inp23];

end