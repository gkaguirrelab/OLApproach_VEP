function [expParam, VEP] = runVEPexperiment()
% A function that runs a metropsis VEP experiment

% Syntax:
%  [expParam] = runVEPexperiment();

% Description:
%   This function prompts input of experimental parameters, sets the
%   path to save files, calls functions for setting up and recording the VEP and microphone data, then
%   saves the microphone and VEP data

%
% Output:
%  expParams           - A structure that defines the specifics of the
%                             experiment (observer ID, session ID,
%                             channel protocol, and date of experiment)



%% Enter information about the experiment, subject and session we're working with
commandwindow;

expParam=struct;

expParam.observerID=input('Enter observer ID:','s');
expParam.experimentID=input('Enter experiment ID:','s');
expParam.sessionID=input('Enter session ID:','s');
expParam.Date = datestr(now, 'yyyy-mm-dd');

%% Prep to save
savePath = fullfile([getpref('OLApproach_VEP', 'DataPath') 'Experiments/OLApproach_VEP/'...
     expParam.experimentID '/Subject_' observerID]);
if ~exist(savePath,'dir')
    mkdir(savePath);
end

%% Microphone recording

% grab audio data
audioOutput = getaudiodata(audioRecObj);

% plot audio trace
plotFig = figure('name', 'plotFig');
plot(0:4/64000:4-1/64000, audioOutput)
ylabel('Amplitude')
xlabel('Time (s)')
title('Audio Output')


%% VEP recording

VEP=RecordVEP();

%% Save VEP, parameter, and microphone data

% convention for saving the VEP data file is Experiment ID, observer ID,
% and session ID

filename=['Exp' expParam.experimentID '_' expParam.observerID expParam.sessionID '.mat'];

save(filename,'VEP','expParam')

end % end function