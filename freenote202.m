clear all
close all
clc

syms u am vm x0 v0 a0 xf vf af real
syms t1 t2 t3 t4 t5 t6 t7 real

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

x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
x2 = x1 + v1*t2 + 1/2*a1*t2^2;
x3 = x2 + v2*t3 + 1/2*a2*t3^2 - 1/6*u*t3^3;
x4 = x3 + v3*t4 + 1/2*a3*t4^2;
x5 = x4 + v4*t5 + 1/2*a4*t5^2 - 1/6*u*t5^3;
x6 = x5 + v5*t6 + 1/2*a5*t6^2;
x7 = x6 + v6*t7 + 1/2*a6*t7^2 + 1/6*u*t7^3;

%%
% for phase portrait
figure(1);clf
hold on
y = linspace(-20,20,100);

for kkk = -30:1.5:30
   plot(1/40*y.^2+kkk,y) 
end
for kkk = -30:1.5:30
   plot(-1/40*y.^2+kkk,y) 
end

% axis([-10 10 -10 10])
box on
grid on
axis equal
axis([-20 20 -20 20]/2)



%% case 1   __
%          /  \___                1 3 5 7 2 6 4
%                 \__/     

a7_ = simplify(subs(a7,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (af+am)/u]));
v7_ = simplify(subs(v7,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (af+am)/u]));
x7_ = simplify(subs(x7,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (af+am)/u]));

a3_ = simplify(subs(a3,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (af+am)/u]));

v3_ = simplify(subs(v3,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (af+am)/u]));

chad = simplify(vm - v3_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

v7_ = simplify(subs(v7_,t2,t2_));
x7_ = simplify(subs(x7_,t2,t2_));
chad = simplify(vf - v7_);
A = simplify(diff(chad,t6));
B = simplify(chad - A*t6);
t6_ = -B / A;
simplify(subs(chad,t6,t6_))

x7_ = simplify(subs(x7_,t6,t6_));
chad = simplify(xf - x7_);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%% case 2
%          /\__          1 2 3 5 6 7 
%              \__/

a7_ = simplify(subs(a7,[t2 t5 t7],[0 am/u (af+am)/u]));
v7_ = simplify(subs(v7,[t2 t5 t7],[0 am/u (af+am)/u]));
x7_ = simplify(subs(x7,[t2 t5 t7],[0 am/u (af+am)/u]));

chad = simplify(a3);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v7_ = simplify(subs(v7_,t1,t1_));
chad = simplify(v7_ - vf);
A = simplify(diff(chad,t6));
B = simplify(chad - A*t6);
t6_ = -B / A;
simplify(subs(chad,t6,t6_))

v3_ = simplify(subs(v3,[t2 t5 t7 t1 t6],[0 am/u (af+am)/u t1_ t6_]));
% v3_ = (- a0^2 + 2*t3^2*u^2 + 2*v0*u)/(2*u) = vm
% t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);
% if t3sqr < 0
%     continue
% end
% otherwise
t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);
x7_ = simplify(subs(x7_,[t1 t6],[t1_ t6_]));
chad = simplify(xf - x7_);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%% case 3    ___
%           /   \__         1 2 3 5 6 7
%                  \/

a7_ = simplify(subs(a7,[t6 t3 t1],[0 am/u (am-a0)/u]));
v7_ = simplify(subs(v7,[t6 t3 t1],[0 am/u (am-a0)/u]));
x7_ = simplify(subs(x7,[t6 t3 t1],[0 am/u (am-a0)/u]));

v3_ = simplify(subs(v3,[t6 t3 t1],[0 am/u (am-a0)/u]));
chad = simplify(vm - v3_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

chad = simplify(af - a7_);
A = simplify(diff(chad,t7));
B = simplify(chad - A*t7);
t7_ = -B / A;
simplify(subs(chad,t7,t7_))

v7_ = simplify(subs(v7_,[t2 t7],[t2_ t7_]));
% v7_ = (af^2 - 2*t5^2*u^2 + 2*vm*u)/(2*u) = vf
t5sqr = (-2*u*vf + af^2 + 2*vm*u)/(2*u^2);

x7_ = simplify(subs(x7_,[t2 t7],[t2_ t7_]));
chad = simplify(x7_ - xf);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%% case 4    
%           /\____         1 2 3 4 5 6 7
%                 \/

a7_ = simplify(subs(a7,[t2 t6],[0 0]));
v7_ = simplify(subs(v7,[t2 t6],[0 0]));
x7_ = simplify(subs(x7,[t2 t6],[0 0]));

a3_ = simplify(subs(a3,[t2 t6],[0 0]));

chad = simplify(a3);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v3_ = simplify(subs(v3,[t1 t2 t6],[t1_ 0 0]));
% v3_ = (- a0^2 + 2*t3^2*u^2 + 2*v0*u)/(2*u) = vm
t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);

a7_ = simplify(subs(a7_,t1,t1_));
chad = simplify(a7_ - af);
A = simplify(diff(chad,t7));
B = simplify(chad - A*t7);
t7_ = -B / A;
simplify(subs(chad,t7,t7_))

v7_ = simplify(subs(v7_,[t1 t7],[t1_ t7_]));
% v7_ = (- a0^2 + af^2 + 2*t3^2*u^2 - 2*t5^2*u^2 + 2*v0*u)/(2*u) = vf
t5sqr = (-2*u*vf - a0^2 + af^2 + 2*t3sqr*u^2 + 2*v0*u)/(2*u^2 );

x7_ = simplify(subs(x7_,[t1 t7],[t1_ t7_]));
chad = simplify(x7_ - xf);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%%
clear all
close all
clc

syms u am vm x0 v0 a0 xf vf af real
syms t1 t2 t3 t4 t5 t6 t7 real

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

%% case 5    ___     ___
%           /   \___/   \     1 2 3 4 5 6 7
%

a7_ = simplify(subs(a7,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (am-af)/u]));
v7_ = simplify(subs(v7,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (am-af)/u]));
x7_ = simplify(subs(x7,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (am-af)/u]));
v3_ = simplify(subs(v3,[t1 t3 t5 t7],[(am-a0)/u am/u am/u (am-af)/u]));

chad = simplify(vm - v3_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

v7_ = simplify(subs(v7_,t2,t2_));
x7_ = simplify(subs(x7_,t2,t2_));
chad = simplify(vf - v7_);
A = simplify(diff(chad,t6));
B = simplify(chad - A*t6);
t6_ = -B / A;
simplify(subs(chad,t6,t6_))

x7_ = simplify(subs(x7_,t6,t6_));
chad = simplify(xf - x7_);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%% case 6     ___
%            /   \__/\       1 3 6
%

a7_ = simplify(subs(a7,[t6 t3 t1],[0 am/u (am-a0)/u]));
v7_ = simplify(subs(v7,[t6 t3 t1],[0 am/u (am-a0)/u]));
x7_ = simplify(subs(x7,[t6 t3 t1],[0 am/u (am-a0)/u]));

v3_ = simplify(subs(v3,[t6 t3 t1],[0 am/u (am-a0)/u]));
chad = simplify(vm - v3_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

chad = simplify(af - a7_);
A = simplify(diff(chad,t7));
B = simplify(chad - A*t7);
t7_ = -B / A;
simplify(subs(chad,t7,t7_))

v7_ = simplify(subs(v7_,[t2 t7],[t2_ t7_]));
% v7_ = (- af^2 + 2*t5^2*u^2 + 2*vm*u)/(2*u) = vf;
t5sqr = (2*u*vf + af^2 - 2*vm*u)/(2*u^2);

x7_ = simplify(subs(x7_,[t2 t7],[t2_ t7_]));
chad = simplify(x7_ - xf);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%% case 7        ___
%           /\__/   \    1 2 3 4 5 6 7
%

a7_ = simplify(subs(a7,[t2 t5 t7],[0 am/u (am-af)/u]));
v7_ = simplify(subs(v7,[t2 t5 t7],[0 am/u (am-af)/u]));
x7_ = simplify(subs(x7,[t2 t5 t7],[0 am/u (am-af)/u]));

chad = simplify(a3);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v7_ = simplify(subs(v7_,t1,t1_));
chad = simplify(v7_ - vf);
A = simplify(diff(chad,t6));
B = simplify(chad - A*t6);
t6_ = -B / A;
simplify(subs(chad,t6,t6_))

v3_ = simplify(subs(v3,[t2 t5 t7 t1 t6],[0 am/u (am-af)/u t1_ t6_]));
% v3_ = (- a0^2 + 2*t3^2*u^2 + 2*v0*u)/(2*u) = vm
% t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);
% if t3sqr < 0
%     continue
% end
% otherwise
t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);
x7_ = simplify(subs(x7_,[t1 t6],[t1_ t6_]));
chad = simplify(x7_ - xf);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%% case 8
%          /\___/\
%

a7_ = simplify(subs(a7,[t2 t6],[0 0]));
v7_ = simplify(subs(v7,[t2 t6],[0 0]));
x7_ = simplify(subs(x7,[t2 t6],[0 0]));

a3_ = simplify(subs(a3,[t2 t6],[0 0]));

chad = simplify(a3);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v3_ = simplify(subs(v3,[t1 t2 t6],[t1_ 0 0]));
% v3_ = (- a0^2 + 2*t3^2*u^2 + 2*v0*u)/(2*u) = vm
t3sqr = (2*u*vm + a0^2 - 2*v0*u)/(2*u^2);

a7_ = simplify(subs(a7_,t1,t1_));
chad = simplify(a7_ - af);
A = simplify(diff(chad,t7));
B = simplify(chad - A*t7);
t7_ = -B / A;
simplify(subs(chad,t7,t7_))

v7_ = simplify(subs(v7_,[t1 t7],[t1_ t7_]));
% v7_ = (- a0^2 - af^2 + 2*t3^2*u^2 + 2*t5^2*u^2 + 2*v0*u)/(2*u) = vf
t5sqr = (2*u*vf + a0^2 + af^2 - 2*t3sqr*u^2 - 2*v0*u)/(2*u^2);

x7_ = simplify(subs(x7_,[t1 t7],[t1_ t7_]));
chad = simplify(x7_ - xf);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

%%
clear all
close all
clc

syms u am vm x0 v0 a0 xf vf af real
syms t1 t2 t3 t4 t5 t6 t7 real

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

x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
x2 = x1 + v1*t2 + 1/2*a1*t2^2;
x3 = x2 + v2*t3 + 1/2*a2*t3^2 - 1/6*u*t3^3;
x4 = x3 + v3*t4 + 1/2*a3*t4^2;
x5 = x4 + v4*t5 + 1/2*a4*t5^2 - 1/6*u*t5^3;
x6 = x5 + v5*t6 + 1/2*a5*t6^2;
x7 = x6 + v6*t7 + 1/2*a6*t7^2 + 1/6*u*t7^3;

%% case 9   __
%          /  \                1 2 3 4 5 7
%              \__/     

a7_ = simplify(subs(a7,[t1 t3 t4 t5 t7],[(am-a0)/u am/u 0 am/u (af+am)/u]));
v7_ = simplify(subs(v7,[t1 t3 t4 t5 t7],[(am-a0)/u am/u 0 am/u (af+am)/u]));
x7_ = simplify(subs(x7,[t1 t3 t4 t5 t7],[(am-a0)/u am/u 0 am/u (af+am)/u]));

% v3_ = simplify(subs(v3,[t1 t3 t4 t5 t7],[(am-a0)/u am/u 0 am/u (af+am)/u]));

chad = simplify(vf - v7_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

x7_ = simplify(subs(x7_,t2,t2_));
chad = simplify(x7_ - xf);


%% case 10         333
%          /\         1 2 3 4 5 6 7    
%            \__/   

a7_ = simplify(subs(a7,[t2 t4 t5 t7],[0 0 am/u (af+am)/u]));
v7_ = simplify(subs(v7,[t2 t4 t5 t7],[0 0 am/u (af+am)/u]));
x7_ = simplify(subs(x7,[t2 t4 t5 t7],[0 0 am/u (af+am)/u]));

v3_ = simplify(subs(v3,[t2 t4 t5 t7],[0 0 am/u (af+am)/u]));

chad = simplify(a7_ - af);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v7_ = simplify(subs(v7_,t1,t1_));
chad = simplify(v7_ - vf);
A = simplify(diff(chad,t6));
B = simplify(chad - A*t6);
t6_ = -B / A;
simplify(subs(chad,t6,t6_))

x7_ = simplify(subs(x7_,[t1 t6],[t1_ t6_]));
chad = simplify(xf - x7_);

%% case 11   ___    555
%           /   \       1 2 3 4 5 6 7
%                \/

a7_ = simplify(subs(a7,[t6 t4 t3 t1],[0 0 am/u (am-a0)/u]));
v7_ = simplify(subs(v7,[t6 t4 t3 t1],[0 0 am/u (am-a0)/u]));
x7_ = simplify(subs(x7,[t6 t4 t3 t1],[0 0 am/u (am-a0)/u]));

v3_ = simplify(subs(v3,[t6 t4 t3 t1],[0 0 am/u (am-a0)/u]));


chad = simplify(af - a7_);
A = simplify(diff(chad,t7));
B = simplify(chad - A*t7);
t7_ = -B / A;
simplify(subs(chad,t7,t7_))

v7_ = simplify(subs(v7_,t7,t7_));
chad = simplify(vf - v7_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

x7_ = simplify(subs(x7_,[t2 t7],[t2_ t7_]));
chad = simplify(x7_ - xf);

%% case 12    
%           /\         1 2 3 4 5 6 7
%             \/

a7_ = simplify(subs(a7,[t2 t4 t6],[0 0 0]));
v7_ = simplify(subs(v7,[t2 t4 t6],[0 0 0]));
x7_ = simplify(subs(x7,[t2 t4 t6],[0 0 0]));

a3_ = simplify(subs(a3,[t2 t4 t6],[0 0 0]));
v3_ = simplify(subs(v3,[t2 t4 t6],[0 0 0]));

chad = simplify(a3_);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

a7_ = simplify(subs(a7_,t1,t1_));
chad = simplify(a7_ - af);
A = simplify(diff(chad,t5));
B = simplify(chad - A*t5);
t5_ = -B / A;
simplify(subs(chad,t5,t5_))

v7_ = simplify(subs(v7_,[t1 t5],[t1_ t5_]));
% v7_ = (- a0^2 - af^2 + 4*af*t7*u + 2*t3^2*u^2 - 2*t7^2*u^2 + 2*v0*u)/(2*u) = vf
t3sqr = (2*u*vf + a0^2 + af^2 - 4*af*t7*u + 2*t7^2*u^2 - 2*v0*u )/(2*u^2);

x7_ = simplify(subs(x7_,[t1 t5],[t1_ t5_]));
chad = simplify(x7_ - xf);
% chad = second order poly with t7

%%
clear all
close all
clc

syms u am vm x0 v0 a0 xf vf af real
syms t1 t2 t3 t4 t5 t6 t7 real

a1 = a0 + t1*u;
a2 = a1;

v1 = v0 + a0*t1 + 1/2*u*t1^2;
v2 = v1 + a1*t2;

% case 1    /
%          /

v2_ = simplify(subs(v2,t2,0));
chad = simplify(v2_ + vm);
chad1 = chad

% case 2   __
%         /

% a1 == am => am = a0 + t1*u => t1 = (am - a0)/u
v2_ = simplify(subs(v2,t1,(am-a0)/u));
chad = simplify(v2_ + vm);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))
t11 = (am-a0)/u
t21 = t2_;

%%
% a1 = a0 - t1*u;
% a2 = a1;
% 
% v1 = v0 + a0*t1 - 1/2*u*t1^2;
% v2 = v1 + a1*t2;
% 
% % case 3  \
% %          \
% 
% v2_ = simplify(subs(v2,t2,0));
% chad = simplify(v2_ - vm);
% chad2 = chad
% 
% % case 4  \____
% %          
% % a1 == am => am = a0 + t1*u => t1 = (am - a0)/u
% v2_ = simplify(subs(v2,t1,(a0+am)/u));
% chad = simplify(v2_ - vm);
% A = simplify(diff(chad,t2));
% B = simplify(chad - A*t2);
% t2_ = -B / A;
% simplify(subs(chad,t2,t2_))
% t12 = (a0+am)/u
% t22 = t2_

%%
clear all
close all
clc

syms u am vm x2 v2 a2 real
syms t1 t2 real

% a1 = a0;
% a2 = a1 - t2*u;
a1 = a2 + t2*u;
a0 = a1;

% v1 = v0 + a0*t1;
% v2 = v1 + a1*t2 - 1/2*u*t2^2;
v1 = v2 - a1*t2 + 1/2*u*t2^2;
v0 = v1 - a0*t1;

% x1 = x0 + v0*t1 + 1/2*a0*t1^2;
% x2 = x1 + v1*t2 + 1/2*a1*t2^2 - 1/6*u*t2^3;
x1 = x2 - v1*t2 - 1/2*a1*t2^2 + 1/6*u*t2^3;
x0 = x1 - v0*t1 - 1/2*a0*t1^2;

% case 1   
%           \

v0_ = simplify(subs(v0,t1,0));
chad = simplify(v0_ - vm);
chad1 = chad;


% case 2  ___ 
%            \
%             \   

% a1 == am => am = a0 + t1*u => t1 = (am - a0)/u
v0_ = simplify(subs(v0,t2,(am-a2)/u));
chad = simplify(v0_ - vm);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))
t2 = (am-a2)/u
t1 = t2_;


%%
clear all
close all
clc

syms u am vm x0 v0 a0 xf vf af real
syms t1 t2 t3 t4 t5 real

a1 = a0 + t1*u;
a2 = a1;
a3 = a2 - t3*u;
a4 = a3;
a5 = a4 + t5*u;

v1 = v0 + a0*t1 + 1/2*u*t1^2;
v2 = v1 + a1*t2;
v3 = v2 + a2*t3 - 1/2*u*t3^2;
v4 = v3 + a3*t4;
v5 = v4 + a4*t5 + 1/2*u*t5^2;

x1 = x0 + v0*t1 + 1/2*a0*t1^2 + 1/6*u*t1^3;
x2 = x1 + v1*t2 + 1/2*a1*t2^2;
x3 = x2 + v2*t3 + 1/2*a2*t3^2 - 1/6*u*t3^3;
x4 = x3 + v3*t4 + 1/2*a3*t4^2;
x5 = x4 + v4*t5 + 1/2*a4*t5^2 + 1/6*u*t5^3;

%% case 9   __
%          /  \                1 2 3 4 5 7
%              \__/     

a5_ = simplify(subs(a5,[t1 t3 t5],[(am-a0)/u 2*am/u (af+am)/u]));
v5_ = simplify(subs(v5,[t1 t3 t5],[(am-a0)/u 2*am/u (af+am)/u]));
x5_ = simplify(subs(x5,[t1 t3 t5],[(am-a0)/u 2*am/u (af+am)/u]));

chad = simplify(vf - v5_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

x5_ = simplify(subs(x5_,t2,t2_));
chad = simplify(x5_ - xf);


%% case 10         333
%          /\         1 2 3 4 5 6 7    
%            \__/   

a5_ = simplify(subs(a5,[t2 t5],[0 (af+am)/u]));
v5_ = simplify(subs(v5,[t2 t5],[0 (af+am)/u]));
x5_ = simplify(subs(x5,[t2 t5],[0 (af+am)/u]));

chad = simplify(a5_ - af);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v5_ = simplify(subs(v5_,t1,t1_));
chad = simplify(v5_ - vf);
A = simplify(diff(chad,t4));
B = simplify(chad - A*t4);
t4_ = -B / A;
simplify(subs(chad,t4,t4_))

x5_ = simplify(subs(x5_,[t1 t4],[t1_ t4_]));
chad = simplify(xf - x5_);

%% case 11   ___    555
%           /   \       1 2 3 4 5 6 7
%                \/

a5_ = simplify(subs(a5,[t4 t1],[0 (am-a0)/u]));
v5_ = simplify(subs(v5,[t4 t1],[0 (am-a0)/u]));
x5_ = simplify(subs(x5,[t4 t1],[0 (am-a0)/u]));

chad = simplify(af - a5_);
A = simplify(diff(chad,t3));
B = simplify(chad - A*t3);
t3_ = -B / A;
simplify(subs(chad,t3,t3_))

v5_ = simplify(subs(v5_,t3,t3_));
chad = simplify(vf - v5_);
A = simplify(diff(chad,t2));
B = simplify(chad - A*t2);
t2_ = -B / A;
simplify(subs(chad,t2,t2_))

x5_ = simplify(subs(x5_,[t2 t3],[t2_ t3_]));
chad = simplify(x5_ - xf);

%% case 12    
%           /\         1 2 3 4 5 6 7
%             \/

a5_ = simplify(subs(a5,[t2 t4],[0 0]));
v5_ = simplify(subs(v5,[t2 t4],[0 0]));
x5_ = simplify(subs(x5,[t2 t4],[0 0]));

% a3_ = simplify(subs(a3,[t2 t4 t6],[0 0 0]));
% v3_ = simplify(subs(v3,[t2 t4 t6],[0 0 0]));
% 
% chad = simplify(a3_);
% A = simplify(diff(chad,t1));
% B = simplify(chad - A*t1);
% t1_ = -B / A;
% simplify(subs(chad,t1,t1_))

% a5_ = simplify(subs(a5_,t1,t1_));
chad = simplify(a5_ - af);
A = simplify(diff(chad,t1));
B = simplify(chad - A*t1);
t1_ = -B / A;
simplify(subs(chad,t1,t1_))

v5_ = simplify(subs(v5_,t1,t1_));
chad = simplify(v5_ - vf);
A = simplify(diff(chad,t5));
B = simplify(chad - A*t5);
t5_ = -B / A;
simplify(subs(chad,t5,t5_))

x5_ = simplify(subs(x5_,[t1 t5],[t1_ t5_]));
chad = simplify(x5_ - xf);
% chad = second order poly with t7




