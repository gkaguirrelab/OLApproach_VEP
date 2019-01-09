function [plotFig] = testVEP(protocolParams)
% A quick function to test if the VEP is up and running
%
% Syntax:
%  [plotFig] = testVEP(protocolParams)

% Description:
%   This function records VEP activity over a 5 second window, prompting
%   the operator when that window begins on screen. This function is
%   intended to be used as part of a pre-flight routine just prior to
%   beginning an experiment where we want to make sure all of our equipment
%   is working properly.

% Inputs:
%   protocolParams        - A struct that defines the basics of the
%                           experiment. I don't believe it actually does
%                           anything in this routine.
% Outputs:
%   plotFig               - A figure handle, used to easily clean up after
%                           running this function or potentially running it
%                           multiple times.


vepOutput = SquintRecordVEP(...
                'recordingDurationSecs', 5, ...
                'simulate', false, ...
                'verbose', true);

            
plotFig = figure('name', 'plotFig');
plot(vepOutput.timebase, vepOutput.response(1,:));
xlabel('Time (s)')
ylabel('Voltage (mV)')
title('VEP')
            
end
