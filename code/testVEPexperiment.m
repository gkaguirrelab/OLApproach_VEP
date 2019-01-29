function [VEP, audioRec] = testVEPexperiment()
% A function that runs pre-experiment testing for
% OLApproach_VEP Experiments

% Syntax:
%  [expParam] = testVEPexperiment();

% Description:
%   This function tests the functioning of the VEP, TTL pulse from metropsis and microphone


%% Test Microphone recording

recObj=audiorecorder;

% record 5 seconds of audio for testing purposes
disp('Start speaking.')
recordblocking(recObj, 5);
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
VEP=RecordVEP('recordingDurationSecs',5);

figure(2)
plot(VEP.timebase,VEP.response(2,:))
title('VEP'); xlabel('time(s)');ylabel('mV');
ax=gca;
ax.Box='off'; ax.TickDir='out';

end % end function