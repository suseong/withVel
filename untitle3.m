clear
clc

for j=1:100
init  = [20*(rand(1,1)-0.5) 20*(rand(1,1)-0.5) 16*(rand(1,1)-0.5)];
final = [20*(rand(1,1)-0.5) 20*(rand(1,1)-0.5) 16*(rand(1,1)-0.5)];

init
final

%%
figure(13);clf;
hold on

input = [20 2 5];
acc = flip(0.2:0.2:20);
markers = {'.','o','x','+'};

tf = [];
for k=1:length(acc)
    input_ = input; input_(2) = acc(k);
    [inp_,tt_] = calc_minT_cV_(init,final,input_);
    if ~isempty(inp_)
        if length(inp_) > 2
            keyboard
        end
        for kk = 1:length(inp_)
            plot(acc(k),tt_{kk}(end),markers{kk});
        end
        if tt_{kk}(end) > 50
            break;
        end
    else
        break;
    end
end

% figure(14);clf;
% % subplot(2,1,1)
% hold on
% % subplot(2,1,2)
% % hold on
% vm = flip(0.5:0.1:5);
% 
% for k = 1:length(vm)
%     input = [20 4 vm(k)];
%     [inp_,tt_] = calc_minT_cV_(init,final,input);
%     if ~isempty(inp_)
%         for kk = 1:length(inp_)
% %             subplot(2,1,1)
%             plot(vm(k),tt_{kk}(end),'.')
% %             subplot(2,1,2)
% %             plot(vm(k),inp_{kk}(4),'.')
%         end
%     else
%         break;
%     end
% end

pause(0.1)
if k == 1
    keyboard
end

end
