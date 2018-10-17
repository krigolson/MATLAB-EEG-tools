function [EEG] = deleteChannel(EEG)
    % get user input or quit
    prompt = {'Enter the channel to remove:'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'0'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    for counter = 1:length(OUTEEG.chanlocs)
        if strcmp(OUTEEG.chanlocs(counter).labels,answer)
            EEG = pop_select(EEG, 'nochannel', counter);
            EEG.channelsRemoved = [EEG.channelsRemoved answer];
            break
        end
    end
end
