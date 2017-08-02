function [inp,tt,pos,vel,acc,newInit,newFinal] = calc_minT_cV(init,final,input,kkk)

u = input(1); am = input(2); vm = input(3);

% consts1 = [u am vm-am^2/u/2];
consts2 = [u am vm];

[newStateFront,tsqFront,inpFront] = frontPart2(init,final,consts2);
[newStateBack,tsqBack,inpBack] = backPart2(init,final,consts2);
[tsq,inp,profileType] = calc_mintime_traj_7(newStateFront{3},newStateBack{1},input);

newInit{1} = newStateFront{3}; newInit{2} = sum(tsqFront);
newFinal{1} = newStateBack{1};   

if ~isempty(tsq)    
    if iscell(tsq)
        for k=1:length(tsq)
            totalTime(k) = sum(tsq{k});
        end
        [~,idx] = sort(totalTime);
        tsq = tsq{idx(kkk)};
        inp = inp{idx(kkk)};
    end
    
    newFinal{2} = sum([tsqFront tsq]);
    
    inp_ = [inp(1) 0 -inp(1) 0 -inp(1) 0 inp(1)];
    
    tsq = [tsqFront tsq tsqBack];
    inp = [inpFront inp_ inpBack];
    
    acc = init(3); vel = init(2); pos = init(1);
    
    for i=1:11
        acc(i+1) = acc(i) + tsq(i)*inp(i);
        vel(i+1) = vel(i) + acc(i)*tsq(i) + 1/2*inp(i)*tsq(i)^2;
        pos(i+1) = pos(i) + vel(i)*tsq(i) + 1/2*acc(i)*tsq(i)^2 + 1/6*inp(i)*tsq(i)^3;
    end
    
    for i=1:11
        tt(i) = sum(tsq(1:i));
    end
    
    if min(tt) < 0
        keyboard
    end
    
    if abs(vel(3:9)) > input(3)
        keyboard
    end
    
    if abs(acc(3:9)) > input(2)
        keyboard
    end
else
%     keyboard
    inp = [];
    tt = [];
    pos = [];
    vel = [];
    acc = [];
end

end
