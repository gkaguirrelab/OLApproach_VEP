function [vepDataStruct] = recordVEP(varargin)
% Records VEP data via a call to the LabJack device
%
% Syntax:
%  function [vepDataStruct] = RecordVEP(varargin)
%
% Description:
%   Utility routine to openn communication with a LabJack device, and then
%   record data for a specified number of seconds.
%
%   We record two analog channels from the LabJack. Channel 0 is the TTL
%   pulse which is output from the Display++ monitor and read in through an
%   analog channel on the LabJack. Channel 1 is the analog input from the
%   biopack amplifier and carries the visual evoked potential signal.
%
% Inputs:
%   none
%
% Optional key/value pair:
%  'recordingDurationSecs' - Scalar. The length of recording for a single
%                           stimulus block in seconds
%  'channelIDs'           - 1xn vector of the analog channel to be
%                           recorded from the LabJack. VEP data on AIN1=1,
%                           TTL data on AIN0=0
%  'frequencyInHz'        - Scalar.
%  'verbose'              - Logical. Flag that is passed to the LabJack
%                           object code to control verbosity.
%
% Output:
%	vepDataStruct         - A structure with the fields:
%                               timebase - 1xt vectors in units of msecs
%                               response - 2xt vectors in voltage units
%                                   measured from the TTL line in and EEG
%                                   device during the recording period.
%                               params - the p.Results structure
%


%% Parse input
p = inputParser;
p.addParameter('recordingDurationSecs',2,@isnumeric);
p.addParameter('channelIDs',[0 1],@isnumeric);
p.addParameter('frequencyInHz',1000,@isnumeric);
p.addParameter('verbose',false,@islogical);

p.parse(varargin{:});


%% Instantiate a LabJack object
labjackOBJ = LabJackU6('verbosity', double(p.Results.verbose));

%% Record the EEG
% We place the recording in a try-catch block as mysterious errors can
% occur in LabJack land.
try
    % Configure analog input sampling
    labjackOBJ.configureAnalogDataStream(p.Results.channelIDs, p.Results.frequencyInHz);
    
    % Acquire the data
    labjackOBJ.startDataStreamingForSpecifiedDuration(p.Results.recordingDurationSecs);
    
    % Place the data in a response structure
    vepDataStruct.timebase = labjackOBJ.timeAxis;
    vepDataStruct.response = labjackOBJ.data';
    vepDataStruct.params = p.Results;
    
    % Close-up shop
    labjackOBJ.shutdown();
    
catch err
    % Close up shop
    labjackOBJ.shutdown();
    rethrow(err)
end % try-catch

end % function
