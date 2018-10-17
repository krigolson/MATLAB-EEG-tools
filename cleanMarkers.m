function [markers,EEG] = cleanMarkers(EEG)

markerCounter = 1;

    for counter = 1:length(EEG.event)
        
        if strmatch(EEG.event(counter).code,'Stimulus')
            
            markers(markerCounter,1) = str2num(EEG.event(counter).type(2:end));
            EEG.event(counter).type = str2num(EEG.event(counter).type(2:end));
            markers(markerCounter,2) = EEG.event(counter).latency;
            markerCounter = markerCounter + 1;
            
        else
            
            EEG.event(counter).type = 0;
            
        end
        
    end
    
    EEG.allMarkers = markers;

end