function [expParam] = prepVEPexperiment()
% A function that controls much of the pre-experiment behavior for
% OLApproach_Squint Experiments

% Syntax:
%  [ expParam ] = prepVEPexperiment(protocolParams);

% Description:
%   This function prompts input of experimental parameters, and sets the
%   path to save files

%
% Output:
%  expParams           - A structure that defines the specifics of the
%                             experiment (observer ID, session ID,
%                             channel protocol, and date of experiment)



%% Enter information about the subject and session we're working with
commandwindow;

expParam.observerID=input('Enter observer ID:','s');
expParam.experimentID=input('Enter experiment ID:','s');
expParam.sessionID=input('Enter session ID:','s');
expParam.Date = datestr(now, 'yyyy-mm-dd');

%% Prep to save
savePath = fullfile(getpref('OLApproach_VEP', 'DataPath'), 'Experiments', expParam.experimentID, expParam.observerID);
if ~exist(savePath,'dir')
    mkdir(savePath);
end

end % end function