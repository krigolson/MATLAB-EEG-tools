    % determine artifacts for each marker
    OUTEEG = [];
    OUTEEG = pop_epoch(EEG,epochMarkers,defaultEpoch);
    OUTEEG = artifactRejectionDifference(OUTEEG,artifactCriteriaDifference);
    OUTEEG = artifactRejectionGradient(OUTEEG,artifactCriteriaGradient);
    percentDifference = sum(OUTEEG.artifactDifference,2)/size(OUTEEG.data,3)*100;
    percentGradient = sum(OUTEEG.artifactGradient,2)/size(OUTEEG.data,3)*100;
    rejectedDifference = max(sum(OUTEEG.artifactDifference,2));
    totalDifference = size(OUTEEG.data,3);
    rejectedGradient = max(sum(OUTEEG.artifactGradient,2));
    artifactBarInfo = [percentDifference percentGradient];
    totalGradient = size(OUTEEG.data,3);
    
    % code to generate variance per second and plot
    x1 = 1;
    x2 = EEG.srate;
    variances = [];
    allVariances = [];
    while 1   
        temp = [];
        temp = EEG.data(:,x1:x2);
        variances = var(temp,'',2);
        allVariances = [allVariances variances];
        x1 = x2 + 1;
        x2 = x2 + EEG.srate;
        if x2 > length(EEG.data)
            break
        end
    end
    CIs = [];
    labels = [];
    for counter = 1:size(EEG.data,1) 
        CIs(counter,:) = makeCIs(allVariances(counter,:));
        labels{counter} = EEG.chanlocs(counter).labels;   
    end
    meanVariances = [];
    meanVariances = mean(allVariances,2);
    
    % code to get marker count for each marker
    for counter = 1:length(markers)
        markerLabels{counter} = [num2str(markers(counter)) ' : ' num2str(count(counter))];
    end
    markerCount = [markers count];