function [VEP, audioRec] = testVEPexperiment(DurInSecs)
% A function that runs pre-experiment testing for
% OLApproach_VEP Experiments to ensure the VEP signal looks good, and the
% microphone data is working properly

% Syntax:
%  [expParam] = testVEPexperiment(DurInSecs);

% INPUT
% - DurInSecs specifies the duration in seconds to record the test data

%OUTPUT
% - VEP contains the VEP signal from AIN1
% - audioRec is a struct that contains the audio data and frequency

% Description:
%   This function tests the functioning of the VEP, TTL pulse from metropsis and microphone


%% Test Microphone recording

recObj=audiorecorder;

% record 5 seconds of audio for testing purposes
disp('Start speaking.')
recordblocking(recObj, DurInSecs);
disp('End of Recording.');

% play back audio
play(recObj)

audioRec.Fs=recObj.SampleRate;
audioRec.data=getaudiodata(recObj);

% plot audio trace
figure(1)
plot(audioRec.data)
ylabel('Amplitude')
xlabel('Time (s)')
title('Audio Output')

%% Test VEP recording

% Record 5 seconds of VEP data for testing purposes
VEP=RecordVEP('recordingDurationSecs',DurInSecs);

figure(2)
plot(VEP.timebase,VEP.response(2,:))
title('VEP'); xlabel('time(s)');ylabel('mV');
ax=gca;
ax.Box='off'; ax.TickDir='out';

end % end function