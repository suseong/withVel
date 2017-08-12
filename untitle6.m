% clear
% % clc
% 
% init = [-7.8669    9.2380   -7.9259];
% final = [5.4982    6.3461    5.8991];

%%
figure(13);clf;
hold on

input = [20 2 5];
acc = flip(0.2:0.1:20);
markers = {'.','o','x','+'};
tf = [];
for k=1:length(acc)
    input_ = input; input_(2) = acc(k);
    [inp_,tt_] = calc_minT_cV_(init,final,input_);
    if ~isempty(inp_)
        for kk = 1:length(inp_)
            plot(acc(k),tt_{kk}(end),markers{kk})
        end
        if tt_{kk}(end) > 50
            break;
        end
    else
        break;
    end
end
