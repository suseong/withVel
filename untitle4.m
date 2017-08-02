figure(14);clf;
hold on
vm = flip(0.1:0.1:5);

for k = 1:length(vm)
    input = [20 5 vm(k)];
    [inp_,tt_] = calc_minT_cV_(init,final,input);
    if ~isempty(inp_)
        for kk = 1:length(inp_)
            plot(vm(k),tt_{kk}(end),'o')
        end
    else
        break;
    end
end
