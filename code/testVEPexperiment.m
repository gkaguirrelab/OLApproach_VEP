function [expParam, VEP] = testVEPexperiment()
% A function that runs pre-experiment testing for
% OLApproach_VEP Experiments

% Syntax:
%  [expParam] = testVEPexperiment();

% Description:
%   This function tests the functioning of the VEP, TTL pulse from metropsis and microphone

%
% Output:
%  expParams           - A structure that defines the specifics of the
%                             experiment (observer ID, session ID,
%                             channel protocol, and date of experiment)


%% Test Microphone recording

recObj=audiorecorder;

% record 5 seconds of audio for testing purposes
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.');

% play back audio
play(recObj)

% plot audio trace
y = getaudiodata(recObj);
plot(y)
ylabel('Amplitude')
xlabel('Time (s)')
title('Audio Output')

%% Test VEP recording

VEP=RecordVEP();


end % end function