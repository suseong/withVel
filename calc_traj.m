function [p,v,a,t_] = calc_traj(init,input,tsq)

t_ = linspace(0,tsq(end),1000);
tsq = [0 tsq];
dt = diff(tsq);

p0 = init(1); v0 = init(2); a0 = init(3);

a_key = a0;
v_key = v0;
p_key = p0;

for k = 1:length(input)
   a_key(k+1) = a_key(k) + dt(k)*input(k); 
   v_key(k+1) = v_key(k) + dt(k)*a_key(k) + 1/2*dt(k)^2*input(k);
   p_key(k+1) = p_key(k) + dt(k)*v_key(k) + 1/2*dt(k)^2*a_key(k) + 1/6*dt(k)^3*input(k);
end

for k = 1:length(t_)
    if t_(k) < tsq(2)
        idx = 1;
    elseif and(t_(k) >= tsq(2), t_(k) < tsq(3))
        idx = 2;
    elseif and(t_(k) >= tsq(3), t_(k) < tsq(4))
        idx = 3;
    elseif and(t_(k) >= tsq(4), t_(k) < tsq(5))
        idx = 4;
    elseif and(t_(k) >= tsq(5), t_(k) < tsq(6))
        idx = 5;
    elseif and(t_(k) >= tsq(6), t_(k) < tsq(7))
        idx = 6;
    elseif and(t_(k) >= tsq(7), t_(k) < tsq(8))
        idx = 7;
    elseif and(t_(k) >= tsq(8), t_(k) < tsq(9))
        idx = 8;
    elseif and(t_(k) >= tsq(9), t_(k) < tsq(10))
        idx = 9;
    elseif and(t_(k) >= tsq(10), t_(k) < tsq(11))
        idx = 10;
    elseif and(t_(k) >= tsq(11), t_(k) < tsq(12))
        idx = 11;
    elseif and(t_(k) >= tsq(12), t_(k) < tsq(13))
        idx = 12;
    elseif and(t_(k) >= tsq(13), t_(k) < tsq(14))
        idx = 13;
    end

    p0 = p_key(idx); v0 = v_key(idx); a0 = a_key(idx); u = input(idx);
    dt_ = t_(k) - tsq(idx);
    
    p(k) = p0 + v0*dt_ + 1/2*a0*dt_^2 + 1/6*u*dt_^3;
    v(k) = v0 + a0*dt_ + 1/2*u*dt_^2;
    a(k) = a0 + u*dt_;
end

end