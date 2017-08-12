function [pos,vel,acc] = calc_pva(init,final,input,tsq,funcNum)

t1 = tsq(1);
t2 = tsq(2);
t3 = tsq(3);
t4 = tsq(4);
t5 = tsq(5);
t6 = tsq(6);
t7 = tsq(7);

a0 = init(3); v0 = init(2); x0 = init(1);
af = final(3); vf = final(2); xf = final(1);

u = input(1);

if funcNum > 4 && funcNum < 9
    a1 = a0 + t1*u;
    a2 = a1;
    a3 = a2 - t3*u;
    a4 = a3;
    a5 = a4 + t5*u;
    a6 = a5;
    a7 = a6 - t7*u;
    
    v1 = v0 + a0*t1 + 1/2*u*t1^2;
    v2 = v1 + a1*t2;
    v3 = v2 + a2*t3 - 1/2*u*t3^2;
    v4 = v3 + a3*t4;
    v5 = v4 + a4*t5 + 1/2*u*t5^2;
    v6 = v5 + a5*t6;
    v7 = v6 + a6*t7 - 1/2*u*t7^2;
    
    x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
    x2 = x1 + v1*t2 + 1/2*a1*t2^2;
    x3 = x2 + v2*t3 + 1/2*a2*t3^2 - 1/6*u*t3^3;
    x4 = x3 + v3*t4 + 1/2*a3*t4^2;
    x5 = x4 + v4*t5 + 1/2*a4*t5^2 + 1/6*u*t5^3;
    x6 = x5 + v5*t6 + 1/2*a5*t6^2;
    x7 = x6 + v6*t7 + 1/2*a6*t7^2 - 1/6*u*t7^3;
else
    a1 = a0 + t1*u;
    a2 = a1;
    a3 = a2 - t3*u;
    a4 = a3;
    a5 = a4 - t5*u;
    a6 = a5;
    a7 = a6 + t7*u;
    
    v1 = v0 + a0*t1 + 1/2*u*t1^2;
    v2 = v1 + a1*t2;
    v3 = v2 + a2*t3 - 1/2*u*t3^2;
    v4 = v3 + a3*t4;
    v5 = v4 + a4*t5 - 1/2*u*t5^2;
    v6 = v5 + a5*t6;
    v7 = v6 + a6*t7 + 1/2*u*t7^2;
    
    t3_ = 0:0.1:t3;
    for k=1:length(t3_)
       v3_(k) = v2 + a2*t3_(k) - 1/2*u*t3_(k)^2; 
    end
    
    x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
    x2 = x1 + v1*t2 + 1/2*a1*t2^2;
    x3 = x2 + v2*t3 + 1/2*a2*t3^2 - 1/6*u*t3^3;
    x4 = x3 + v3*t4 + 1/2*a3*t4^2;
    x5 = x4 + v4*t5 + 1/2*a4*t5^2 - 1/6*u*t5^3;
    x6 = x5 + v5*t6 + 1/2*a5*t6^2;
    x7 = x6 + v6*t7 + 1/2*a6*t7^2 + 1/6*u*t7^3;
end

pos = [x0 x1 x2 x3 x4 x5 x6 x7];
vel = [v0 v1 v2 v3 v4 v5 v6 v7];
acc = [a0 a1 a2 a3 a4 a5 a6 a7];

if max(abs(vel(2:6))) > abs(input(3)) + 1e-3
    pos = []; vel = []; acc = [];
elseif max(abs(acc)) > abs(input(2)) + 1e-3
    pos = []; vel = []; acc = [];
elseif abs(v7 - vf) > 1e-2
    pos = []; vel = []; acc = [];    
elseif abs(x7 - xf) > 1e-2
    pos = []; vel = []; acc = [];    
elseif abs(a7 - af) > 1e-2
    pos = []; vel = []; acc = [];    
elseif max(abs(v3_)) > abs(input(3))+1e-2
    pos = []; vel = []; acc = [];
end


end