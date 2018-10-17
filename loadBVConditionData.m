function [ERP] = loadBVConditionData(numberOfParticipants,numberOfConditions,numberOfChannels,conditionOrder,epochTimes,samplingRate,useChannelNames)
% by Olav Krigolson, June 2018
% This function loads BV exported conditional data with channel names. It
% returns an ERP.data matrix = channels x time x conditions x participants. It
% all returns a EEGLAB channel locations file for topographical plotting (ERP.chanlocs).
% The function reorders the channels for consitency aligned with the first
% participant (in case channels were deleted and interpolated).
% You need to pass this function the number of participants, the number of
% conditions, and the number of channels.
% It also asks for the actual condition order [1 2 4 3] for example if you
% want to swap the 3rd and 4th conditions. For no swap, just go [1 2 3 4].
% Finally, for a time vector you need to pass it the epoch window [-200
% 596] and the sampling rate 250.
% set useChannelNames to 1 if being used else 0 for no channel names

    %Directories and pathways
    [fileNames,filePath] = uigetfile('*.txt','Select the exported Brain Vision files to load','MultiSelect', 'on');
    cd(filePath); %Change directory to where the data is

    fileNumber = 1;

    for fileCounter = 1:numberOfParticipants
        
        disp('Current Participant')
        fileCounter

        for conditionCounter = 1:numberOfConditions
            
            disp('Current Condition')
            conditionCounter

            fileName = fileNames{fileNumber};
            
            disp('Current Filename');
            fileName
            
            data = [];
            if useChannelNames == 1
                data = importBVConditionERPData(fileName, 1, numberOfChannels);
            else
                data = dlmread(fileName);
            end
            tempERP(:,:,conditionCounter,fileCounter) = data;
            if useChannelNames == 1
                channelNames{fileCounter,:} = importBVChannelNames(fileName, 1, numberOfChannels);
            end
            
            fileNumber = fileNumber + 1;

        end

    end
    
    disp('Size of Data Matrix');
    size(tempERP)
            
    % generate time data
    ERP.time = [epochTimes(1):1/samplingRate*1000:epochTimes(2)];
    ERP.time(end) = []; % remove last data point
    
    % check to ensure channels in the right order for everyone, assume
    % person number one is in the right order
    
    if useChannelNames == 1

        correctChannelOrder = channelNames{1};
        sortedERP(:,:,:,1) = tempERP(:,:,:,1);

        for participantCounter = 2:numberOfParticipants

            for channelCounter = 1:numberOfChannels

                whereItIs = find(channelNames{participantCounter} == correctChannelOrder(channelCounter));
                sortedERP(channelCounter,:,:,participantCounter) = tempERP(whereItIs,:,:,participantCounter);

            end

        end
        
    else
        sortedERP = tempERP;
    end
    
    % reorder conditions in case names are not in a logical order
   
   ERP.data = zeros(numberOfChannels,length(ERP.time),numberOfConditions,numberOfParticipants);
   for conditionCounter = 1:numberOfConditions
       ERP.data(:,:,conditionCounter,:) = sortedERP(:,:,conditionOrder(conditionCounter),:);
   end

    % get channel location info
    
    if useChannelNames == 1
        allLocs = readlocs('Standard-10-20-Cap81.ced');
        channelCounter = 1;
        for counter = 1:length(allLocs)
            check = find(allLocs(counter).labels == correctChannelOrder);
            if length(check) > 0
                ERP.chanlocs(channelCounter) = allLocs(counter);
                channelCounter = channelCounter + 1;
            end
        end
    end
    
end