function [tsq,inp,profileType] = calc_mintime_traj_7(init,final,input)

isFound = 0;
input_p = [input(1) input(2) input(3)];

for k=1:4
    funcName = getFuncName7(k);
    calc_xf = str2func(funcName);
    inp = input_p;
    tsq_ = calc_xf(init,final,inp);
    if max(tsq_) > 0
       [p,v,a] = calc_pva(init,final,inp,tsq_,1);
       if ~isempty(p)
           isFound = 1;
           tsq = tsq_;
           profileType = k;
       end
    end
    if isFound
        break;
    end
    if isFound
        break;
    end
end

if isFound == 0
    chad = 1;
    tsq = [];
    inp = [];
    profileType = [];

    for k=1:4
        funcName = getFuncName7(k);
        calc_xf = str2func(funcName);
        inp = -input_p;
        tsq_ = calc_xf(init,final,inp);
        if max(tsq_) > 0
            [p,v,a] = calc_pva(init,final,inp,tsq_,1);
            if ~isempty(p)
                isFound = 1;
                tsq = tsq_;
                profileType = k;
            end
        end
        if isFound
            break;
        end
        if isFound
            break;
        end
    end
 
    if isFound == 0
        inp = [];
        for k=9:12
            [tsqOut,errOut] = bisection7(init,final,input,k);
            for j=1:length(tsqOut)
%                 if min(tsqOut{j}) > -1e-3
                if min(tsqOut{j}) > -1e-4
                    [p,v,a] = calc_pva(init,final,input,tsqOut{j},k);
                    if ~isempty(p)
                        tsq{chad} = tsqOut{j};
                        inp{chad} = input;
                        profileType{chad} = k;
                        chad = chad + 1;
                    end
                end
            end
        end
        
        for k=9:12
            [tsqOut,errOut] = bisection7(init,final,-input,k);
            for j=1:length(tsqOut)
%                 if min(tsqOut{j}) > -1e-3
                if tsqOut{j} > -1e-4
                    [p,v,a] = calc_pva(init,final,-input,tsqOut{j},k);
                    if ~isempty(p)
                        tsq{chad} = tsqOut{j};
                        inp{chad} = -input;
                        profileType{chad} = k;
                        chad = chad + 1;
                    end
                end
            end
        end
    end
end

end