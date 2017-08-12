function [tsqOut,errOut] = bisection7(init,final,input,funcNum)

    funcName = getFuncName7(funcNum);
    calc_xf = str2func(funcName);
    
    smallCont = [];
    bigCont = [];
    k = 0;

    if funcNum == 9
        timeTrials = 0:0.01:3;
    else
        timeTrials = 0:0.002:input(1)/input(2);
    end
    
    errTrials = zeros(length(timeTrials),1);

    for k=1:length(timeTrials)
        [~,errTrials(k)] = calc_xf(init,final,input,timeTrials(k));
    end

    chad = 0;
    for k=1:length(timeTrials)-1
        if errTrials(k)*errTrials(k+1) <= 0
            chad = chad + 1;
            if errTrials(k) < 0
                smallCont{chad} = [timeTrials(k);errTrials(k)];
                bigCont{chad} = [timeTrials(k+1);errTrials(k+1)];
            else
                bigCont{chad} = [timeTrials(k);errTrials(k)];
                smallCont{chad} = [timeTrials(k+1);errTrials(k+1)];
            end
        end
    end

    errOut = [];
    tsqOut = [];

    if and(~isempty(smallCont),~isempty(bigCont))
        for j = 1:length(smallCont)
            time = (smallCont{j}(1) + bigCont{j}(1))/2;
            [~,err] = calc_xf(init,final,input,time);
            
            if err < 0
                smallCont{j} = [time;err];
            else
                bigCont{j} = [time;err];
            end
            
            for k = 1:200
                if (err >= 0)
                    time = (time + smallCont{j}(1)) / 2;
                else
                    time = (time + bigCont{j}(1)) / 2;
                end
                [tsq,err] = calc_xf(init,final,input,time);
                
                if err < 0
                    smallCont{j} = [time;err];
                else
                    bigCont{j} = [time;err];
                end
                if (norm(err) < 1e-4)
                    errOut{j} = err;
                    tsqOut{j} = tsq;
                    break;
                end
            end
        end
    end
    
end