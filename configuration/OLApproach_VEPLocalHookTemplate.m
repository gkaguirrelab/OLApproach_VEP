function OLApproach_VEPLocalHook
% Configure things for working on MELA VEP/metropsis project
%
% For use with the ToolboxToolbox.  If you copy this into your
% ToolboxToolbox localToolboxHooks directory (by default,
% ~/localToolboxHooks) and delete "LocalHooksTemplate" from the filename,
% this will get run when you execute
%   tbUseProject('OLApproach_VEP')
% to set up for this project.  You then edit your local copy to match your local machine.
%
% The main thing that this does is define Matlab preferences that specify input and output
% directories.
%
% You will need to edit the project location and i/o directory locations
% to match what is true on your computer.

%% Say hello
fprintf('Running OLApproach_VEP local hook\n');
theApproach = 'OLApproach_VEP';

%% Remove old preferences
if (ispref(theApproach))
    rmpref(theApproach);
end

%% Specify base paths for materials and data
[~, userID] = system('whoami');
userID = strtrim(userID);
switch userID
    case {'melanopsin' 'pupillab'}
        materialsBasePath = ['/Users/' userID '/Dropbox (Aguirre-Brainard Lab)/MELA_materials'];
        dataBasePath = ['/Users/' userID '/Dropbox (Aguirre-Brainard Lab)/MELA_data/'];
        adminBasePath = ['/Users/' userID '/Dropbox (Aguirre-Brainard Lab)/MELA_admin/'];
        
    case {'dhb'}
        materialsBasePath = ['/Users1'  '/Dropbox (Aguirre-Brainard Lab)/MELA_materials'];
        dataBasePath = ['/Users1' '/Dropbox (Aguirre-Brainard Lab)/MELA_data/'];
    case {'nicolas'}
        materialsBasePath = '/Volumes/Manta TM HD/Dropbox (Aguirre-Brainard Lab)/MELA_materials';
        dataBasePath = '/Volumes/Manta TM HD/Dropbox (Aguirre-Brainard Lab)/MELA_data';
    otherwise
        materialsBasePath = ['/Users/' userID '/Dropbox (Aguirre-Brainard Lab)/MELA_materials'];
        dataBasePath = ['/Users/' userID '/Dropbox (Aguirre-Brainard Lab)/MELA_data/'];
        adminBasePath = ['/Users/' userID '/Dropbox (Aguirre-Brainard Lab)/MELA_admin/'];
        
end

%% Set prefs for data
setpref(theApproach,'DataPath',fullfile(dataBasePath));

%% Set pref to point at the code for this approach
setpref(theApproach,'CodePath', fullfile(tbLocateProject(theApproach),'code'));


%% Set the default speak rate
setpref(theApproach, 'SpeakRateDefault', 230);
