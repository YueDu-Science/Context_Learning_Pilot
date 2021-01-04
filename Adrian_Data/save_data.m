clear; clc; close all;

path = ('D:\Project\Online\Context_Learning\Adrian_Data'); % the data folder path
folder = dir(path);
cd(path);

PILOT_DATA = table;
INFO = table;
csv = dir('*.*csv');

for i = 1:size(char(csv.name),1)
    T = readtable(csv(i).name);
    clear tmp;
    if T.session(1) == 1
        tmp = T(:,{'stim_key_map_ctx1', 'stim_key_map_ctx2', 'participant', 'Session', 'date', 'Symbol', ...
            'ctx', 'Stim_Type', 'Finger', 'Block_Type', 'Grp_B', 'Brp_R', 'Block_Num', 'Set_Prep_Time',...
            'Repeat_Count','Trial_Count', 'RT_Press_Hand_keys', 'RT_Press_Hand_rt',...
            'RT_Press_Hand_corr','TR_Press_Hand_keys',...
            'TR_Press_Hand_corr', 'TR_Press_Hand_rt', 'RT_Press_keys', 'RT_Press_corr',...
            'RT_Press_rt', 'TR_Press_keys', 'TR_Press_corr', 'TR_Press_rt'});
    elseif T.session(1) == 6
        tmp = T(:,{'stim_key_map_ctx1', 'stim_key_map_ctx2', 'participant', 'Session', 'date', 'Symbol', ...
            'ctx', 'Stim_Type', 'Finger', 'Block_Type', 'Grp_B', 'Brp_R', 'Block_Num', 'Set_Prep_Time',...
            'Repeat_Count','Trial_Count', 'TR_Press_keys', 'TR_Press_corr', 'TR_Press_rt'});
        tmp.RT_Press_Hand_keys(:) = {'a'};
        tmp.RT_Press_Hand_rt(:) = nan;
        tmp.RT_Press_Hand_corr(:) = nan;
        tmp.TR_Press_Hand_keys(:) = {'a'};
        tmp.TR_Press_Hand_corr(:) = nan;
        tmp.TR_Press_Hand_rt(:) = nan;
        tmp.RT_Press_keys(:) = {'a'};
        tmp.RT_Press_corr(:) = nan;
        tmp.RT_Press_rt(:) = nan;
    else
        tmp = T(:,{'stim_key_map_ctx1', 'stim_key_map_ctx2', 'participant', 'Session', 'date', 'Symbol', ...
            'ctx', 'Stim_Type', 'Finger', 'Block_Type', 'Grp_B', 'Brp_R', 'Block_Num', 'Set_Prep_Time',...
            'Repeat_Count','Trial_Count', 'RT_Press_keys', 'RT_Press_corr',...
            'RT_Press_rt'});
        tmp.RT_Press_Hand_keys(:) = {'a'};
        tmp.RT_Press_Hand_rt(:) = nan;
        tmp.RT_Press_Hand_corr(:) = nan;
        tmp.TR_Press_Hand_keys(:) = {'a'};
        tmp.TR_Press_Hand_corr(:) = nan;
        tmp.TR_Press_Hand_rt(:) = nan;
        tmp.TR_Press_keys(:) = {'a'};
        tmp.TR_Press_corr(:) = nan;
        tmp.TR_Press_rt(:) = nan;
    end
    PILOT_DATA = [PILOT_DATA; tmp];
end

DATA = PILOT_DATA;

datafname = ['pilot_data.mat'];
save(datafname, 'DATA');