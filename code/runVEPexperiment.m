function [expParam, vepDataStruct, audioRec] = runVEPexperiment(durInSecs)
% A function that runs a metropsis VEP experiment
%
% Syntax:
%  [expParam] = runVEPexperiment();
%
% Description:
%	This function prompts input of experimental parameters, sets the
%   path to save files, calls functions for setting up and recording the
%   VEP and microphone data, then saves the microphone and VEP data
%
% Input:
%   durInSecs             - Scalar, units of seconds. The duration of the
%                           entire recording, it should be 5-10 seconds
%                           longer than metropsis recording session
%
% Output:
%   expParams             - A structure that defines the specifics of the
%                           experiment (observer ID, session ID,
%                           channel protocol, and date of experiment)
%   vepDataStruct           - A structure that contains VEP data, TTL pulse,
%                           and timebase for both analog signals
%   audioRec              - A structure that contains mic data, and 
%                           sampling rate (Fs)
%


%% Enter information about the experiment, 
% subject and session we're working with. This should match up with
% metropsis.
commandwindow;

expParam=struct;

expParam.observerID=input('Enter observer ID (e.g., MELA_0232):','s');
expParam.experimentID=input('Enter experiment ID (this is Metropsis file name):','s');
expParam.sessionID=input('Enter session ID (this is the Metropsis session ID):','s');
expParam.Date = datestr(datetime('now'));


%% Start audio recording
recObj=audiorecorder;
record(recObj,durInSecs);


%% VEP recording
vepDataStruct=recordVEP('recordingDurationSecs',durInSecs);


%% End microphone recording
audioRec.Fs=recObj.SampleRate;
audioRec.data=getaudiodata(recObj);


%% Establish directory for saving
% The path is defined by experiment ID / observer ID
savePath = fullfile(getpref('OLApproach_VEP', 'DataPath'),'Experiments', ...
    'OLApproach_VEP',['Exp_' expParam.experimentID],['Subject_' expParam.observerID]);
if ~exist(savePath,'dir')
    mkdir(savePath);
end

%% Establish filename for saving
filename=['Exp' expParam.experimentID '_' expParam.observerID expParam.sessionID '.mat'];

%% Save the data
save(fullfile(savePath,filename),'vepDataStruct','expParam','audioRec')

end % end function