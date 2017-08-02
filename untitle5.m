% 
% 
% u = 20; am = 5; vm = 5;
% a1 = -10:0.1:-am;
% a2 = -am:0.1:10;
% a3 = -10:0.1:am;
% a4 =  am:0.1:10;
% 
% pu =  1/(2*u)*a1.^2 + vm - 1/u*am^2;
% pd = -1/(2*u)*a2.^2 + vm;
% mu =  1/(2*u)*a3.^2 - vm;
% md = -1/(2*u)*a4.^2 - vm + 1/u*am^2;
% 
% for k=1:1000
% 
%     figure(1);clf
%     hold on
%     box on
%     grid on
%     plot(pu,a1,'linewidth',3)
%     plot(pd,a2,'linewidth',3)
%     plot(mu,a3,'linewidth',3)
%     plot(md,a4,'linewidth',3)
%     plot([-10 vm-1/2/u*am^2],[am am])
%     plot([-vm+1/2/u*am^2 10],[-am -am])
% 
%     init = 20*(rand(3,1)-0.5);
%     [sts,tsq,isq] = frontPart2(init,[0 0 0],[u am vm]);
% 
%     plot(sts{1}(2),sts{1}(3),'ok')
%     plot(sts{2}(2),sts{2}(3),'sqk')
%     plot(sts{3}(2),sts{3}(3),'*k')
%     
%     axis equal
%     axis([-10 10 -10 10])
%     keyboard
% end

%%
% u = 20; am = 5; vm = 5;
% a2 = -10:0.1:am;
% a1 =  am:0.1:10;
% a4 = -10:0.1:-am;
% a3 = -am:0.1:10;
% 
% pu =  1/(2*u)*a1.^2 + vm - 1/u*am^2;
% pd = -1/(2*u)*a2.^2 + vm;
% mu =  1/(2*u)*a3.^2 - vm;
% md = -1/(2*u)*a4.^2 - vm + 1/u*am^2;
% 
% for k=1:1000
% clc
%     figure(1);clf
%     hold on
%     box on
%     grid on
%     plot(pu,a1,'linewidth',3)
%     plot(pd,a2,'linewidth',3)
%     plot(mu,a3,'linewidth',3)
%     plot(md,a4,'linewidth',3)
%     plot(-[-10 vm-1/2/u*am^2],[am am],'linewidth',3)
%     plot(-[-vm+1/2/u*am^2 10],[-am -am],'linewidth',3)
% 
%     final = 20*(rand(3,1)-0.5);
%     [sts,tsq,isq] = backPart2([0 0 0],final,[u am vm]);
% 
% %     init = 20*(rand(3,1)-0.5);
% %     [sts,tsq,isq] = frontPart2(init,[0 0 0],[u am vm]);
% % 
%     plot(sts{1}(2),sts{1}(3),'ok')
%     plot(sts{2}(2),sts{2}(3),'sqk')
%     plot(sts{3}(2),sts{3}(3),'*k')
%     
%     axis equal
%     axis([-10 10 -10 10])
%     keyboard
% end

%%
u = 20; am = 7; vm = 4;
a1 = -10:0.1:-am;
a2 = -am:0.1:10;
a3 = -10:0.1:am;
a4 =  am:0.1:10;
a5 = -10:0.1:0;
a6 =  0:0.1:10;

pu =  1/(2*u)*a1.^2 + vm - 1/u*am^2;
pd = -1/(2*u)*a2.^2 + vm;
mu =  1/(2*u)*a3.^2 - vm;
md = -1/(2*u)*a4.^2 - vm + 1/u*am^2;

ppu =  1/(2*u)*a5.^2 + vm;
ppd = -1/(2*u)*a2.^2 + vm + 1/u*am^2;
mmu =  1/(2*u)*a3.^2 - vm - 1/u*am^2;
mmd = -1/(2*u)*a6.^2 - vm;


figure(1);clf;clc;
hold on
box on
grid on
plot(pu,a1,'k','linewidth',2)
plot(pd,a2,'k','linewidth',2)
plot(mu,a3,'k','linewidth',2)
plot(md,a4,'k','linewidth',2)
plot(ppu,a5,'k','linewidth',2)
plot(ppd,a2,'k','linewidth',2)
plot(mmu,a3,'k','linewidth',2)
plot(mmd,a6,'k','linewidth',2)

plot([-10 -vm-1/2/u*am^2],[am am],'k','linewidth',2)
plot([-vm+1/2/u*am^2 vm-1/2/u*am^2],[am am],'k','linewidth',2)

plot([vm+1/2/u*am^2 10],[-am -am],'k','linewidth',2)
plot([-vm+1/2/u*am^2 vm-1/2/u*am^2],[-am -am],'k','linewidth',2)

init = 20*(rand(3,1)-0.5);

[sts,tsq,isq] = frontPart3(init,[0 0 0],[u am vm]);
plot(sts{1}(2),sts{1}(3),'sqk')
plot(sts{2}(2),sts{2}(3),'dk')
plot(sts{3}(2),sts{3}(3),'xk')
plot(sts{4}(2),sts{4}(3),'*k')

%%
u = 20; am = 7; vm = 4;
a1 = -10:0.1:-am;
a2 = -am:0.1:10;
a3 = -10:0.1:am;
a4 =  am:0.1:10;
a5 = -10:0.1:0;
a6 =  0:0.1:10;

pu =  1/(2*u)*a4.^2 + vm - 1/u*am^2;
pd = -1/(2*u)*a3.^2 + vm;
mu =  1/(2*u)*a2.^2 - vm;
md = -1/(2*u)*a1.^2 - vm + 1/u*am^2;

ppu =  1/(2*u)*a6.^2 + vm;
ppd = -1/(2*u)*a3.^2 + vm + 1/u*am^2;
mmu =  1/(2*u)*a2.^2 - vm - 1/u*am^2;
mmd = -1/(2*u)*a5.^2 - vm;

figure(1);clf;clc;
hold on
box on
grid on
plot(pu,a4,'k','linewidth',2)
plot(pd,a3,'k','linewidth',2)
plot(mu,a2,'k','linewidth',2)
plot(md,a1,'k','linewidth',2)
plot(ppu,a6,'k','linewidth',2)
plot(ppd,a3,'k','linewidth',2)
plot(mmu,a2,'k','linewidth',2)
plot(mmd,a5,'k','linewidth',2)

plot(flip(-[-10 -vm-1/2/u*am^2]),[am am],'k','linewidth',2)
plot([-vm+1/2/u*am^2 vm-1/2/u*am^2],[am am],'k','linewidth',2)

plot(flip(-[vm+1/2/u*am^2 10]),[-am -am],'k','linewidth',2)
plot([-vm+1/2/u*am^2 vm-1/2/u*am^2],[-am -am],'k','linewidth',2)

for kk = 1:1000000
final = 20*(rand(3,1)-0.5); 
[sts,tsq,isq] = backPart3([0 0 0],final,[u am vm]);
aaa = sts{1};
% plot(sts{1}(2),sts{1}(3),'sqk')
% plot(sts{2}(2),sts{2}(3),'dk')
% plot(sts{3}(2),sts{3}(3),'xk')
% plot(sts{4}(2),sts{4}(3),'*k')
end
