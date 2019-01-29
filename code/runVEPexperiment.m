function [expParam, VEP, audioRec] = runVEPexperiment()
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

%% Microphone recording

recObj=audiorecorder;
record(recObj,220);


%% VEP recording

VEP=RecordVEP('recordingDurationSecs',220);

%% Save VEP, parameter, and audio VDS data
savePath = fullfile([getpref('OLApproach_VEP', 'DataPath') 'Experiments/OLApproach_VEP/'...
     'Exp_' expParam.experimentID '/Subject_' expParam.observerID]);
if ~exist(savePath,'dir')
    mkdir(savePath);
end

% convention for saving the VEP data file is Experiment ID, observer ID,
% and session ID

filename=[savePath '/Exp' expParam.experimentID '_' expParam.observerID expParam.sessionID '.mat'];


audioRec.Fs=recObj.SampleRate;
audioRec.data=getaudiodata(recObj);

save(filename,'VEP','expParam','audioRec')

end % end function