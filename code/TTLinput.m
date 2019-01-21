
function [ttlDataStruct] = TTLoutput(varargin)
% Configure digital input (TTL pulse from metropsis monitor - on FI01 = channel ID 7)
% DIO direction = 1 (output)
% U6 = 6

    % Clear environment
    clear all; clear global; clear Classes; clc;

    % Initialize LabJackDIO object
    ljOBJ = LabJackDIO();
    if (~ljOBJ.deviceIsConfigured)
        disp('A LabJack device was not configured. Exiting now ...');
        return;
    end

    % Configure FIO1 as a digital output channel for TTL
    ljOBJ.configureDIOchannels(LabJackDIO.FIO_1, LabJackDIO.INPUT);
    if (~ljOBJ.DIOconfigurationIsGood)
        disp('>>>> DIO configuration failed. Exiting now.');
        ljOBJ.closeDevice();
    end
    % Record TTL pulse from metropsis

    
    % Close down labjack
    ljOBJ.closeDevice();
end
