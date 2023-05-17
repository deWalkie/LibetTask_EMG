% LIBET TASK

% MODS BEING TRIED OUT BY ARPAN
%__________________________________________________________________________________________________
% TIMING FILE: LibetTask_v_5.m

% USERLOOP CONDITIONS FILE: LibetTask_userloop_v_5.m

%The dial position ranges from 0 to 2pi radians, with initial position
%randomly (uniform distribution) selected. 


function [C,timingfile,userdefined_trialholder] = LibetTask_userloop_v_5(MLConfig,TrialRecord)

% return values
C = [];
timingfile = 'LibetTask_v_5.m';    % Call the relevant timing scripts
userdefined_trialholder = '';  % Create a user-defined place holder


% The very first call to this function is just to retrieve the timing filename before the task begins and we don't want to waste our preset
% values for this, so we just return if it is the first call.
persistent timing_filenames_retrieved 
if isempty(timing_filenames_retrieved)
   timing_filenames_retrieved = true;
   TrialRecord.User.dial_position = []; % User-defined variable name
   return
end

persistent dial_position_seq condition_sequence
dial_position_seq = zeros(1,50);
%dial_position_seq = [36,36,24,36,36,0,0,12,12,24,48,36,0,36,48,24,12,48,48,12,48,0,0,48,24,24,24,36,36,48,24,48,24,48,12,48,12,0,36,24,0,0,12,24,36,12,0,12,0,12];
 
%dial_position_seq = [0,36,0,36,0];

condition_sequence = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...
    1,1,1,1,1,1];  

%condition_sequence = [1,1,1,1,1];
    
condition_index = mod(TrialRecord.CurrentTrialNumber,50) + 1;
%condition_index = mod(TrialRecord.CurrentTrialNumber,5) + 1;
TrialRecord.User.dial_position = dial_position_seq(condition_index);
condition = condition_sequence(condition_index);

%------------------------------------****************************-----------------------------------------------------
%                                           Conditions
%------------------------------------****************************-----------------------------------------------------


switch condition 
    case 1, C = {'pic(circle_red,0,7,200,200)','pic(circle_green,0,7,200,200)',... %use 150 in laptop, use 200 in screen
            'pic(circle_blue,0,7,200,200)','pic(clock4,0,0,650,650)'}; %use 500 in laptop, use 850 in screen, if not try 650 
            Info = 0; timingfile = 'LibetTask_v_5.m';
end

TrialRecord.setCurrentConditionInfo(Info); % Record the info of the trial
TrialRecord.NextCondition = condition;     % Call next condition

end