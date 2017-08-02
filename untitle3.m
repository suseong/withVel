clear
clc

for j=1:100
init  = [10*(rand(1,1)-0.5) 20*(rand(1,1)-0.5) 20*(rand(1,1)-0.5)];
final = [10*(rand(1,1)-0.5) 20*(rand(1,1)-0.5) 20*(rand(1,1)-0.5)];

%%
figure(13);clf;
hold on

input = [100 2 5];
acc = flip(0:0.1:10);
tf = [];
for k=1:length(acc)
    input_ = input; input_(2) = acc(k);
    [inp_,tt_] = calc_minT_cV_(init,final,input_);
    if ~isempty(inp_)
        for kk = 1:length(inp_)
            plot(acc(k),tt_{kk}(end),'.')
        end
    else
        break;
    end
end

figure(14);clf;
% subplot(2,1,1)
hold on
% subplot(2,1,2)
% hold on
vm = flip(0.5:0.1:5);

for k = 1:length(vm)
    input = [100 3 vm(k)];
    [inp_,tt_] = calc_minT_cV_(init,final,input);
    if ~isempty(inp_)
        for kk = 1:length(inp_)
%             subplot(2,1,1)
            plot(vm(k),tt_{kk}(end),'.')
%             subplot(2,1,2)
%             plot(vm(k),inp_{kk}(4),'.')
        end
    else
        break;
    end
end

pause(0.001)
keyboard

end
