% LIBET TASK

% MODS BEING TRIED OUT BY ARPAN
%__________________________________________________________________________________________________
% TIMING FILE: LibetTask_v_5.m

% USERLOOP CONDITIONS FILE: LibetTask_userloop_v_5.m

% TASK DESCRIPTION: Self Initiated Movement

% Syntax:
% eventmarker BehavioralCodes.CodeNumber - number to be time-stamped, represents a behavioral event (has to be a positive integer)
% trial error - single trial error value ranging from 0 to 7 

%Key1: LEFT key - movement (green), run/stop pointer (blue)
%Key3: RIGHT key - end trial


%% -----------------------------------------------------------------------------------------------------------------------------------


% Behavioral codes
hotkey('x', 'escape_screen(); assignin(''caller'',''continue_'',false);');
bhv_code(10,'Relax',20,'Clock Appears',30,'+ Response',40,'No response');  % behavioral codes
bhv_variable('dial_position', TrialRecord.User.dial_position); % behavioral variables

%Detect an available tracker
if exist('mouse_','var'), tracker = mouse_; % Mouse 
elseif exist('touch_','var'), tracker = touch_; showcursor(true); % Touch 
else, error('This demo requires mouse or touch input. Please set it up or turn on the simulation mode.');
end

%TaskObjects
present_red_arrow = 1;
present_green_arrow = 2;
present_blue_arrow = 3;
present_dial = 4;

%Define dial position (in radians)
dial_position = TrialRecord.User.dial_position;

%% ------------------------------------***********************-----------------------------------------------------
%                                         Define Scenes
%--------------------------------------***********************-----------------------------------------------------

% scene 1: In this scene, the fixation_point is presented (TextGraphic #1)
%          and subject is asked to relax.
%----------------------------------------------------------------------------------------------------------------
txt1 = TextGraphic(null_); %allows to display text
txt1.Text = 'Relax'; %text to be printed
txt1.Position = [0 0];
txt1.FontSize = 50;
txt1.FontColor = [255 255 255];
txt1.HorizontalAlignment = 'center';
txt1.VerticalAlignment = 'middle';
tc1 = TimeCounter(txt1); %allows to set duration to display text
tc1.Duration = 2000; % 2s as of now
scene1 = create_scene(tc1);

% scene 11: In this scene, the inter trial window crops up (TextGraphic #11 )
%
%________________________________________________________________________________________________________________________
txt11 = TextGraphic(null_); %allows to display text
txt11.Text = 'Report Urge Time'; %text to be printed
txt11.Position = [0 0];
txt11.FontSize = 50;
txt11.FontColor = [255 255 255];
txt11.HorizontalAlignment = 'center';
txt11.VerticalAlignment = 'middle';
tc11 = TimeCounter(txt11); %allows to set duration to display text
tc11.Duration = 5000; % 5s for subject to report the Urge time
scene11 = create_scene(tc11);

% scene 12: In this scene, the error window crops up (TextGraphic #12 )
%
%________________________________________________________________________________________________________________________
txt12 = TextGraphic(null_); %allows to display text
txt12.Text = 'Incorrect Trial'; %text to be printed
txt12.Position = [0 0];
txt12.FontSize = 50;
txt12.FontColor = [255 0 0];
txt12.HorizontalAlignment = 'center';
txt12.VerticalAlignment = 'middle';
tc12 = TimeCounter(txt12); %allows to set duration to display text
tc12.Duration = 3000; % 7s for subject to report the Urge time
scene12 = create_scene(tc12);



% scene 2: Cue (Beep), after which participant is free to choose when to
%          move. 
%----------------------------------------------------------------------------------------------------------------
%snd2 = AudioSound(null_);
%snd2.List = 'load_waveform({''sin'', 0.1, 2000})';   % 1-kHz sine wave for 100 milliseseqds
%scene2 = create_scene(snd2);

%{
% scene 3: Displays dial. Since pointer is red, withhold movement for one
%          cycle but free to choose to move.
%----------------------------------------------------------------------------------------------------------------
d  = (pi/30)*dial_position; %dial_position - [0,60] 
t = linspace(d, d+2*pi, 150)'; %provides 150 values of theta between range.
x = 7 * cos((2*pi - t)); %x coordinate of circle
y = 7 * sin((2*pi - t)); %y coordinate of circle
ct3 = CurveTracer(null_); %allows taskobject to trace a curve
ct3.setTarget(1); %target is red pointer (TaskObject #1)
ct3.List = [x y];
ct3.Repetition = 1; %to withhold movement for one cycle
kc3 = KeyChecker(mouse_); %allows to detect mouse press
kc3.KeyNum = 1; %left mouse button
or3 = OrAdapter(kc3); %allows to create adapter chains
or3.add(ct3)
scene3 = create_scene(or3,[1,4]);

% scene 4: Dial pointer switches to green. Allowed to move. 
%----------------------------------------------------------------------------------------------------------------
ct4 = CurveTracer(null_);
ct4.setTarget(2);   %target is green pointer (TaskObject #2)
ct4.List = [x y];
ct4.Repetition = 100; %five cycles 
kc4 = KeyChecker(mouse_);
kc4.KeyNum = 1;
tc4 = TimeCounter(null_);
tc4.Duration = 50000; %10s
or4 = OrAdapter(kc4);
or4.add(ct4) 
or4.add(tc4);
scene4 = create_scene(or4,[2,4]);

kc8 = KeyChecker(mouse_);
kc8.KeyNum = 3;

% scene 5: Audio Feedback
%----------------------------------------------------------------------------------------------------------------
snd5 = AudioSound(null_);
or5 = OrAdapter(snd5);
or5.add(kc8) 
snd5.List = 'load_waveform({''sin'', 0.1, 1000})';   % 1-kHz sine wave for 100 millises
scene5 = create_scene(or5);
%}

kc8 = KeyChecker(mouse_);
kc8.KeyNum = 3;

%{
snd5 = AudioSound(null_);
or5 = OrAdapter(snd5);
or5.add(kc8) 
scene5 = create_scene(or5);
%}


%{        
%THIS IS A TEMPLATE CODE____________________________________________________
% Parameters
radius = 7;  % Radius of the circle
centerX = 0; % X-coordinate of the circle center
centerY = 0; % Y-coordinate of the circle center
startTime = 0; % Start time in seconds
endTime = 10;  % End time in seconds
numFrames = 150; % Number of frames

% Generate time values
time = linspace(startTime, endTime, numFrames);

% Calculate angle values
angle = (2 * pi * time / (endTime - startTime)) - (pi / 2);

% Calculate X and Y coordinates of the circle
x = centerX + radius * cos(angle);
y = centerY + radius * sin(angle);

% Create CurveTracer object
ct = CurveTracer(null_);
ct.setTarget(1); % Target is the TaskObject #1
ct.List = [x' y']; % Transpose the coordinate matrices
ct.Repetition = 1; % Tracing once

% Set the duration of the CurveTracer to match the desired time
ct.Duration = endTime - startTime;

% Create the scene
scene = create_scene(ct);

% Run the scene for the specified time
run_scene(scene, endTime - startTime);

%}


% % scene 6: Blue pointer runs to confirm position  
% %----------------------------------- -----------------------------------------------------------------------------
d  = (pi/30)*dial_position; %dial_position - [0,60] 
d1 = d+1.57;
t = linspace(d1, d1+2*pi, 250)'; %provides 750 values of theta between range. 750 = 12.47 s
x = 7.6 * cos(pi-t); %x coordinate of circle
y = 7.6 * sin(pi-t); %y coordinate of circle
ct6 = CurveTracer(null_);
ct6.setTarget(3);   %target is blue pointer (TaskObject #3)
ct6.List = [x y];
ct6.Repetition = 1; % 1 cycle ??? 
%ct6.Duration = 12;
kc6 = KeyChecker(mouse_);
kc6.KeyNum = 1; 
tc6 = TimeCounter(null_);
tc6.Duration = 12470; % 12s for total display duration
or6 = OrAdapter(kc6);
or6.add(kc8);
or6.add(ct6); 
or6.add(tc6);
scene6 = create_scene(or6,[3,4]); %blue pointer running.

% % scene 7: Blue pointer stops to confirm position  
% %----------------------------------------------------------------------------------------------------------------

% kc7 = KeyChecker(mouse_);
% kc7.KeyNum = 1;
% tc7 = TimeCounter(null_);
% tc7.Duration = 2000; % 2s pause?
% or7 = OrAdapter(kc7);
% or7.add(kc8);
% or7.add(tc7);
% scene7 = create_scene(or7,[3,4]); %blue pointer stopped. 
% 





%% ------------------------------------***********************-----------------------------------------------------
%                                         Task Outcomes
%--------------------------------------***********************-----------------------------------------------------
error_type = 1; %Starting trial with error (1 - No response)

run_scene(scene1,10); 


while (~kc8.Success)
    run_scene(scene6,20);
        if kc6.Success %if key pressed while dial pointer is blue.
            run_scene(scene11,30); %correct response
            error_type = 0; %(0 - Correct)
            break;
        else
            run_scene(scene12,40); %Incorrect Trial
            break;
        end
    break;

end



%{
while (~kc8.Success)
    run_scene(scene6,12);
        if kc6.Success %if key pressed while dial pointer is blue.
            run_scene(scene7,10);
            if kc7.Success
                continue;
            end
        end
end
%}

%{
run_scene(scene3,20);
if kc3.Success  %if key pressed while dial pointer is red.
     error_type = 5; % (5 - Early response)
else
    run_scene(scene4,30);
    if kc4.Success %if key pressed while dial pointer is green.
        run_scene(scene5,100);
        while (~kc8.Success)
            run_scene(scene6,40);
            if kc6.Success %if key pressed while dial pointer is blue.
                run_scene(scene7,50);
                if kc7.Success
                    continue;
                end
            end
        end
        run_scene(scene5,100);
        error_type = 0; %(0 - Correct)
    elseif ~tc4.Success %if key not pressed while dial pointer is green before 10s
            error_type = 2; %(2 - Late response)
    end
end
%}


%-------------------------------------------------------------------------------------------------

% Clear screens 
idle(0);

% Add the result to the trial history
trialerror(error_type); 

%-------------------------------------------------------------------------------------------------   