function [EEG] = artifactRejectionDifference(EEG,criteria);

% ARTIFACT REJECTION FUNCTION

% Input segmented EEG data, SEEG - channels x time x segments
% the maximum difference allowed in the segment, eg 50 for 50 uV

disp('Artifact Rejection: Difference...');

artifactDifference = zeros(size(EEG.data,1),size(EEG.data,3));
artifactSize = zeros(size(EEG.data,1),size(EEG.data,3));

for channelCounter = 1:size(EEG.data,1)

    for segmentCounter = 1:size(EEG.data,3)

        voltage_max = [];
        voltage_max = max(EEG.data(channelCounter,:,segmentCounter));

        voltage_min = [];
        voltage_min = min(EEG.data(channelCounter,:,segmentCounter));

        difference = voltage_max - voltage_min;

        if difference > criteria
            artifactDifference(channelCounter,segmentCounter) = 1;
        end
        
        artifactSize(channelCounter,segmentCounter) = difference;
        
    end
 
end

EEG.artifactDifference = artifactDifference;
EEG.artifactDifferenceSize = artifactSize;