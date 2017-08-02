function [inp_,tt] = calc_minT_cV_(init,final,input)

u = input(1); am = input(2); vm = input(3);

% consts1 = [u am vm-am^2/u/2];
consts2 = [u am vm];

[newStateFront,tsqFront,inpFront] = frontPart(init,final,consts2);
[newStateBack,tsqBack,inpBack] = backPart(init,final,consts2);
[tsq,inp,~] = calc_mintime_traj_7(newStateFront{3},newStateBack{1},input);

if ~isempty(tsq)
    if iscell(tsq)
        for k=1:length(tsq)
            totalTime(k) = sum(tsq{k});
        end
        
        [~,idx] = sort(totalTime);
        for k=1:length(tsq)
            tsq_{k} = [tsqFront tsq{idx(k)} tsqBack];
            inp__ = [inp{idx(k)}(1) 0 -inp{idx(k)}(1) 0 -inp{idx(k)}(1) 0 inp{idx(k)}(1)];
            inp_{k} = [inpFront inp__ inpBack];
            
            for kk=1:13
                tt{k}(kk) = sum(tsq_{k}(1:kk));
            end
        end
    else
        tt{1} =  sum([tsqFront tsq tsqBack]);
        inp__ = [inp(1) 0 -inp(1) 0 -inp(1) 0 inp(1)];
        inp_{1} = [inpFront inp__ inpBack];
    end
else
    inp_ = [];
    tt = [];
end

end
