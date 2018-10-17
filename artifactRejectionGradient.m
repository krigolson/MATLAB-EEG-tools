function [EEG] = artifactRejectionGradient(EEG,criteria);

% ARTIFACT REJECTION FUNCTION

% Input segmented EEG data, SEEG - channels x time x segments
% gradient crtieria, eg 50 for 50 uV


disp('Artifact Rejection: Gradient...');

artifactGradient = zeros(size(EEG.data,1),size(EEG.data,3));
artifactSize = zeros(size(EEG.data,1),size(EEG.data,3));

for channelCounter = 1:size(EEG.data,1)

    for segmentCounter = 1:size(EEG.data,3)
        
        voltageGradients = [];
        voltageGradients = abs(diff(EEG.data(channelCounter,:,segmentCounter)));

        check = max(voltageGradients);

        if check > criteria
            artifactGradient(channelCounter,segmentCounter) = 1;
        end
        
        artifactSize(channelCounter,segmentCounter) = check;

    end
    
end

EEG.artifactGradient = artifactGradient;
EEG.artifactGradientSize = artifactSize;