function [tsq,inp,profileType] = calc_mintime_traj_7_(init,final,input)

isFound = 0;
input_p = [input(1) input(2)  input(3)];
input_n = [input(1) input(2) -input(3)];

for k=1:4
    funcName = getFuncName7(k);
    calc_xf = str2func(funcName);
    for kk = 1:2
        if kk == 1
            inp = input_p;
            tsq_ = calc_xf(init,final,inp);
        else
            inp = input_n;
            tsq_ = calc_xf(init,final,inp);
        end
        if max(tsq_) > 0
            isFound = 1;
            tsq = tsq_;
            profileType = k;
        end
        if isFound
            break;
        end        
    end
    if isFound
        break;
    end
end

for k=5:8
    funcName = getFuncName7(k);
    calc_xf = str2func(funcName);
    for kk = 1:2
        if kk == 1
            inp = input_p;
            tsq_ = calc_xf(init,final,inp);
        else
            inp = input_n;
            tsq_ = calc_xf(init,final,inp);
        end
        if max(tsq_) > 0
            isFound = 1;
            tsq = tsq_;
            profileType = k;
        end
        if isFound
            break;
        end
    end
    if isFound
        break;
    end
end

if isFound == 0
    tsq_ = [];
    chad = 1;
    tsq = [];
    inp = [];
    profileType = [];

    for k=1:4
        funcName = getFuncName7(k);
        calc_xf = str2func(funcName);
        for kk = 1:2
            if kk == 1
                inp = -input_p;
                tsq_ = calc_xf(init,final,inp);
            else
                inp = -input_n;
                tsq_ = calc_xf(init,final,inp);
            end
            if max(tsq_) > 0
                isFound = 1;
                tsq = tsq_;
                profileType = k;
            end
            if isFound
                break;
            end
        end
        if isFound
            break;
        end
    end

    for k=5:8
        funcName = getFuncName7(k);
        calc_xf = str2func(funcName);
        for kk = 1:2
            if kk == 1
                inp = -input_p;
                tsq_ = calc_xf(init,final,inp);
            else
                inp = -input_n;
                tsq_ = calc_xf(init,final,inp);
            end
            if max(tsq_) > 0
                isFound = 1;
                tsq = tsq_;
                profileType = k;
            end
            if isFound
                break;
            end
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
                if min(tsqOut{j}) > -1e-3
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
                if min(tsqOut{j}) > -1e-3
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