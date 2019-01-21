% parseVEP
% Code to organize VEP signal and parse trials based on input, and organize
% stimuli by stimulus frequency

% load saved raw data
load 'test_VEP_data2.mat'

% VEP data is p.response(2,:)
% TTL pulse is p.response(1,:);
% timebase is p.timebase

% Bandpass filter for VEP signal
sRate=p.params.frequencyInHz;
lo=0.5; % low cut off frequency
hi=500; % high cut off frequency

d=designfilt('bandpassiir','FilterOrder',20,'HalfPowerFrequency1',lo,...
    'HalfPowerFrequency2',hi,'SampleRate',sRate);
    

VEP_data=filter(d,p.response(2,:));

% VEP_data=p.response(2,:);

clear lo hi

% Find timestamp of TTL pulses
TTL=p.response(1,:);
timestamp=p.timebase;
y=0;
% sync_pulse=cell(1);
% TTL_check{y}=cell(1);

for x=2:length(TTL)
    if TTL(1,x)>4 && TTL(1,(x-1))<4
        y=y+1;
        sync_pulse{y}=timestamp(1,x);
        sync_loc{y}=x;
        TTL_check{y}=TTL(1,x);
    end
end

sync_pulse=cell2mat(sync_pulse);
sync_loc=cell2mat(sync_loc);
TTL_check=cell2mat(TTL_check);

clear x y

% parse VEP data
dur_in_sec=3; % the length of the stimulus presentation
dur_in_freq=dur_in_sec*sRate;

for x=1:length(sync_loc)
    parsed_VEP(x,:)=VEP_data(1,sync_loc(x):sync_loc(x)+dur_in_freq);
end

clear x

XX=1:length(parsed_VEP);
YY=mean(parsed_VEP,1);

subplot(1,2,1)
plot(XX(1,1:1000),YY(1,1:1000),'-k')

subplot(1,2,2)
plot(XX,YY,'-k')
hold off
% pause
% 
% for x=1:(size(parsed_VEP,1))
%     plot(XX,parsed_VEP(x,:))
%     hold off
%     pause
% end
% 
% clear x
