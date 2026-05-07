% Adams / MATLAB Interface - Release 2025.1.0
global ADAMS_sysdir; % used by setup_rtw_for_adams.m
global ADAMS_host; % used by start_adams_daemon.m
machine=computer;
datestr(now)
if strcmp(machine, 'GLNXA64')
   arch = 'linux64';
   setenv('LD_LIBRARY_PATH',strcat('/lib64:',getenv('LD_LIBRARY_PATH')));
elseif strcmp(machine, 'PCWIN64')
   arch = 'win64';
else
   disp( '%%% Error : Platform unknown or unsupported by Adams Controls.' ) ;
   arch = 'unknown_or_unsupported';
   return
end
   [flag, topdir]=system('adams2025_1_SE -top');
if flag == 0
  temp_str=strcat(topdir, '/controls/', arch);
  addpath(temp_str)
  temp_str=strcat(topdir, '/controls/', 'matlab');
  addpath(temp_str)
  temp_str=strcat(topdir, '/controls/', 'utils');
  addpath(temp_str)
  ADAMS_sysdir = strcat(topdir, '');
else
  addpath( 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2025_1\controls/win64' ) ;
  addpath( 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2025_1\controls/matlab' ) ;
  addpath( 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2025_1\controls/utils' ) ;
  ADAMS_sysdir = 'C:\PROGRA~1\MSC~1.SOF\ADAMSS~1\2025_1\' ;
end
ADAMS_exec = '' ;
ADAMS_host = 'LAPTOP-JSCROFU1.nej.cz' ;
ADAMS_cwd ='C:\Users\josef\OneDrive\Dokumenty\msc_adams_upgrade' ;
ADAMS_prefix = 'Dron_vitr_021' ;
ADAMS_static = 'no' ;
ADAMS_solver_type = 'C++' ;
ADAMS_version = '2025_1_SE' ;
ADAMS_communication_interval = 0.005 ;
ADAMS_communications_per_output_step = 1 ;
ADAMS_time_offset = 0.0;
if exist([ADAMS_prefix,'.adm']) == 0
   disp( ' ' ) ;
   disp( '%%% Warning : missing Adams plant model file(.adm) for Co-simulation or Function Evaluation.' ) ;
   disp( '%%% If necessary, please re-export model files or copy the exported plant model files into the' ) ;
   disp( '%%% working directory.  You may disregard this warning if the Co-simulation/Function Evaluation' ) ;
   disp( '%%% is TCP/IP-based (running Adams on another machine), or if setting up MATLAB/Real-Time Workshop' ) ;
   disp( '%%% for generation of an External System Library.' ) ;
   disp( ' ' ) ;
end
ADAMS_init = '' ;
ADAMS_inputs  = 'SV_Thrust_1!SV_Torque_1!SV_Thrust_2!SV_Torque_2!SV_Thrust_3!SV_Torque_3!SV_Thrust_4!SV_Torque_4!VARIABLE_FORCE_UP!VARIABLE_FORCE_RIGHT!VARIABLE_FORCE_BACK' ;
ADAMS_outputs = 'Global_X!Global_Y!Global_Z!V_X!V_Y!V_Z!ROLL!PITCH!YAW!OM_X!OM_Y!OM_Z' ;
ADAMS_pinput = 'Controls_Plant_10.ctrl_pinput' ;
ADAMS_pinput_id = 11 ;
ADAMS_poutput = 'Controls_Plant_10.ctrl_poutput' ;
ADAMS_poutput_id = 11 ;
ADAMS_uy_ids  = [
                   7
                   8
                   9
                   10
                   11
                   12
                   13
                   14
                   33
                   34
                   35
                   25
                   26
                   27
                   22
                   23
                   24
                   19
                   21
                   20
                   18
                   17
                   15
                ] ;
ADAMS_mode   = 'non-linear' ;
tmp_in  = decode( ADAMS_inputs  ) ;
tmp_out = decode( ADAMS_outputs ) ;
disp( ' ' ) ;
disp( '%%% INFO : ADAMS plant actuators names :' ) ;
disp( [int2str([1:size(tmp_in,1)]'),blanks(size(tmp_in,1))',tmp_in] ) ;
disp( '%%% INFO : ADAMS plant sensors   names :' ) ;
disp( [int2str([1:size(tmp_out,1)]'),blanks(size(tmp_out,1))',tmp_out] ) ;
disp( ' ' ) ;
clear tmp_in tmp_out ;
% Adams / MATLAB Interface - Release 2025.1.0
