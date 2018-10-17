function [means CIS stats] = plotBarCIs(data)

    % function to plot two columns of data with CIs on each bar. Does a paired
    % samples t-test and then adds the p-value to the xlabel

    for counter = 1:size(data,2)
        CIs = makeCIs(data(:,counter));
        CIS(1,counter) = CIs(2);
        CIS(2,counter) = CIs(3);
        yErr(counter) = CIs(4);
        means(1,counter) = CIs(1);
        y(counter) = CIs(1);
    end
    
    [H,P, CI, STATS] = ttest(data(:,1),data(:,2));

    barwitherr(yErr,y);
    xlabel(['p = ' num2str(P)]);
    
    stats(1) = P;
    stats(2) = STATS.tstat;
    
end
