function [vepDataStruct] = RecordVEP(varargin)
% function [vepDataStruct] = RecordVEP(varargin)
%
% Utility routine to openn communication with a LabJack device, and then
% record data for a specified number of seconds.
% INPUT:
%   recordingDurationSecs - the length of recording for a single stimulus block in seconds
% OUTPUT:
%    vepDataStruct - A structure with the fields timebase and response.
%    timebase is in units of msecs. Response is the voltage measured from
%    the EEG device during the recording period.
%
%  'channelIDs' - list of  channels to acquire from (AIN1 = 1, AIN2 = 2, AIN3 = 3)


%% Parse input
p = inputParser;
p.addParameter('recordingDurationSecs',306,@isnumeric);
p.addParameter('channelIDs',[0 1],@isnumeric);
p.addParameter('frequencyInHz',2000,@isnumeric);
p.addParameter('simulate',false,@islogical);
p.addParameter('verbose',false,@islogical);

p.parse(varargin{:});

if p.Results.simulate
    vepDataStruct.timebase = 0:1/p.Results.frequencyInHz*1000:(p.Results.recordingDurationSecs*1000)-(1/p.Results.frequencyInHz*1000);
    % Simulate a 1 Hz sinusoid with some noise
    vepDataStruct.response = sin(vepDataStruct.timebase/1000*2*pi);
    vepDataStruct.response = vepDataStruct.response + ...
        normrnd(0,1,size(vepDataStruct.timebase,1),size(vepDataStruct.timebase,2));
else
    
    % Instantiate a LabJack object to handle communication with the device
    labjackOBJ = LabJackU6('verbosity', double(p.Results.verbose));
    
    try
        % Configure analog input sampling (VEP data on AIN1=channel ID 1)
        labjackOBJ.configureAnalogDataStream(p.Results.channelIDs, p.Results.frequencyInHz);
        
        % Acquire the data
        labjackOBJ.startDataStreamingForSpecifiedDuration(p.Results.recordingDurationSecs);
        
        % Place the data in a response structure
        %% NEED TO DO SOME WORK HERE TO LINK THE UNITS OF TIME TO THE STANDARD MSECS OF OUR PACKETS
        vepDataStruct.timebase = labjackOBJ.timeAxis;
        vepDataStruct.response = labjackOBJ.data;
        vepDataStruct.response = vepDataStruct.response'; 
        vepDataStruct.params = p.Results;
        
        % Close-up shop
        labjackOBJ.shutdown();
        
    catch err
        % Close up shop
        labjackOBJ.shutdown();
        rethrow(err)
    end % try-catch
end % is this real life or a simulation?

end % function
