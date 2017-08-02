% clear
% clc

%%
figure(11);clf;
input = [20 5 3];
kkk = 1;
% init  = [10*(rand(1,1)-0.5) 20*(rand(1,1)-0.5) 20*(rand(1,1)-0.5)];
% final = [10*(rand(1,1)-0.5) 20*(rand(1,1)-0.5) 20*(rand(1,1)-0.5)];

[inp,tt,pos,vel,acc,newInit,newFinal] = calc_minT_cV(init,final,input,kkk);

if ~isempty(inp)
    [p,v,a,time] = calc_traj(init,inp,tt);
    subplot(3,1,1)
    hold on
    plot(time,p,'-g','linewidth',3)
    plot(time(1),init(1),'o')
    plot(time(end),final(1),'o')
    plot([0 tt],pos,'xk');
    plot(newInit{2},newInit{1}(1),'rsq','markersize',8)
    plot(newFinal{2},newFinal{1}(1),'rsq','markersize',8)
    subplot(3,1,2)
    hold on
    plot([0 time(end)],[input(3) input(3)],'-y')
    plot([0 time(end)],-[input(3) input(3)],'-y')
    plot(time,v,'-g','linewidth',3)
    plot(time(1),init(2),'o')
    plot(time(end),final(2),'o')
    plot([0 tt],vel,'xk');
    plot(newInit{2},newInit{1}(2),'rsq','markersize',8)
    plot(newFinal{2},newFinal{1}(2),'rsq','markersize',8)
    subplot(3,1,3)
    hold on
    plot([0 time(end)],[input(2) input(2)],'-y')
    plot([0 time(end)],-[input(2) input(2)],'-y')
    plot(time,a,'-g','linewidth',3)
    plot(time,a)
    plot(time(1),init(3),'o')
    plot(time(end),final(3),'o')
    plot([0 tt],acc,'xk');
    plot(newInit{2},newInit{1}(3),'rsq','markersize',8)
    plot(newFinal{2},newFinal{1}(3),'rsq','markersize',8)
    
    T = time(end);
    
    p0 = init(1); v0 = init(2); a0 = init(3);
    pf = final(1); vf = final(2); af = final(3);
    
    chadMat = [720 -360*T 60*T^2;-360*T 168*T^2 -24*T^3; 60*T^2 -24*T^3 3*T^4];
    chadVec = [pf-p0-v0*T-0.5*a0*T^2; vf-v0-a0*T; af-a0];
    abc = 1/T^5*chadMat*chadVec;
    a = abc(1); b = abc(2); c = abc(3);
    
    t__ = linspace(0,T,100);
    
    subplot(3,1,1)
    plot(t__,a/120*t__.^5+b/24*t__.^4+c/6*t__.^3+a0/2*t__.^2+v0*t__+p0,'-b','linewidth',1);
    subplot(3,1,2)
    plot(t__,a/24*t__.^4+b/6*t__.^3+c/2*t__.^2+a0*t__+v0,'-b','linewidth',1);
    subplot(3,1,3)
    plot(t__,a/6*t__.^3+b/2*t__.^2+c*t__+a0,'-b','linewidth',1);
    grid on
end
