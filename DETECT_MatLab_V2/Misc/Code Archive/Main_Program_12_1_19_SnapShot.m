
function simpleGUI
clear all
close all
    padding_x = 15;
    padding_y = 15;
    first_panel_shift_y = 50;
    colmn_1_size = 300;
    colmn_2_size = 300;
    colmn_2_start = 200;
    colmn_3_start = 550;
    colmn_step = 55;
    pos_step = 25;
    x_var_col_size = 50;
    y_var_row_size = 20;
    hFig = figure('Visible','off', 'Menu','none', 'Name','DETECT models', 'Resize','off', 'Position',[100 100 (padding_x*2)+colmn_3_start+(colmn_step*5)+50 225+first_panel_shift_y]);
    movegui(hFig,'center')          %# Move the GUI to the center of the screen

    hBtnGrp = uibuttongroup('Position',[0 0 1 1], 'Units','Normalized');
    title_01 = uicontrol('Style','text', 'Position',[padding_x first_panel_shift_y+185 115 25], 'String','Choose Model to run:');
    title_02 = uicontrol('Style','text', 'Position',[padding_x+250 first_panel_shift_y+185 115 25], 'String','Models Description:');
    title_03 = uicontrol('Style','text', 'Position',[colmn_3_start first_panel_shift_y+185 115 25], 'String','Parameters Values:');
    hEdit3 = uicontrol('Style','text', 'Position',[padding_x+200 first_panel_shift_y 300 20], 'String','Status: Ready');
    
    uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[padding_x first_panel_shift_y+150 colmn_1_size 30], 'String','MatLab DETECT Original NSS', 'Tag','Model_1')
    uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[padding_x first_panel_shift_y+120 colmn_1_size 30], 'String','MatLab DETECT Efficient NSS', 'Tag','Model_2')
    uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[padding_x  first_panel_shift_y+90 colmn_1_size 30], 'String','MatLab DETECT FAKE SS', 'Tag','Model_3')
    uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[padding_x  first_panel_shift_y+60 colmn_1_size 30], 'String','MatLab DETECT SS', 'Tag','Model_4')
    uicontrol('Style','Radio', 'Parent',hBtnGrp, 'HandleVisibility','off', 'Position',[padding_x  first_panel_shift_y+30 colmn_1_size 30], 'String','Rscript DETECT Efficient NSS', 'Tag','Model_5')
    
    disc_M1 =  uicontrol('Style','text', 'Position',[padding_x+colmn_2_start first_panel_shift_y+150 colmn_2_size 25], 'String','- basic original model withou changes');
    disc_M2 =  uicontrol('Style','text', 'Position',[padding_x+colmn_2_start first_panel_shift_y+120 colmn_2_size 25], 'String','- 60 times more efficient model version');
    disc_M3 =  uicontrol('Style','text', 'Position',[padding_x+colmn_2_start first_panel_shift_y+90 colmn_2_size 25], 'String','- keep SWC, Gness, and Tsoil constant');
    disc_M4 =  uicontrol('Style','text', 'Position',[padding_x+colmn_2_start first_panel_shift_y+60 colmn_2_size 25], 'String','- simplified version with stable state solution');
    
    uicontrol('Style','pushbutton', 'String','Run Model', 'Position',[padding_x first_panel_shift_y 200 25], 'Callback',{@button_callback})
%     hEdit3 = uicontrol('Style','text', 'Position',[padding_x first_panel_shift_y-35 200 20], 'String','Status: Ready');
    
%     [colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size]

y_row_position = 0;
x_col_position = 0;
    param_1_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*0) x_var_col_size y_var_row_size], 'String','Rstar');
x_col_position = 1;
    param_1 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*0) x_var_col_size y_var_row_size], 'String','111.54');
x_col_position = 2;
    param_2_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*0) x_var_col_size y_var_row_size], 'String','RrBase');
x_col_position = 3;
    param_2 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*0) x_var_col_size y_var_row_size], 'String','0.00006');
x_col_position = 4;
    param_3_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*0) x_var_col_size y_var_row_size], 'String','Rr_alpha1');
x_col_position = 5;
    param_3 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*0) x_var_col_size y_var_row_size], 'String','11.65');

    
y_row_position = 1;
x_col_position = 0;
    param_4_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Rr_alpha2');
x_col_position = 1;
    param_4 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','20.72');
x_col_position = 2;
    param_5_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Rr_alpha3');
x_col_position = 3;
    param_5 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','-164.16');
x_col_position = 4;
    param_6_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Cstar');
x_col_position = 5;
    param_6 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','711.6094');

    
y_row_position = 2;
x_col_position = 0;
    param_7_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Mstar');
x_col_position = 1;
    param_7 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','12.2568');
x_col_position = 2;     
    param_8_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','RmBase');
x_col_position = 3;
    param_8 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','0.0015');
x_col_position = 4;    
    param_9_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','alpha1');
x_col_position = 5;
    param_9 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','14.05');

    
y_row_position = 3;
x_col_position = 0;
    param_10_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','alpha2');
x_col_position = 1;
    param_10 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','11.05');
x_col_position = 2;
    param_11_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','alpha3');
x_col_position = 3;
    param_11 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','-87.55');
x_col_position = 4;
    param_12_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Km');
x_col_position = 5;
    param_12 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','0.00001');


y_row_position = 4;
x_col_position = 0;
    param_13_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','CUE');
x_col_position = 1;
    param_13 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','0.8');
x_col_position = 2;  
    param_14_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','solfrac');
x_col_position = 3;
    param_14 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','0.0004');
x_col_position = 4;
    param_15_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Dliq');
x_col_position = 5;
    param_15 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','3.17');


y_row_position = 5;
x_col_position = 0;
    param_16_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Eo_Rm');
x_col_position = 1;
    param_16 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','324.6');
x_col_position = 2;
    param_17_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','Eo_Rr');
x_col_position = 3;
    param_17 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','324.6');
x_col_position = 4;
    param_18_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','To');
x_col_position = 5;
    param_18 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','227.5');


y_row_position = 6;
x_col_position = 0;
    param_19_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','alpha4');
x_col_position = 1;
    param_19 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','-4.67');
x_col_position = 2;
    param_20_lable = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','tau');
x_col_position = 3;
    param_20 = uicontrol('Style','edit', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size y_var_row_size], 'String','10');
x_col_position = 4;  
    play_sound_leb = uicontrol('Style','text', 'Position',[colmn_3_start+(colmn_step*x_col_position) first_panel_shift_y+padding_y+(pos_step*y_row_position) x_var_col_size+10 y_var_row_size], 'String','Play Sound');
x_col_position = 5;    
    play_sound = uicontrol('Style','checkbox', 'Position',[colmn_3_start+(colmn_step*x_col_position)+15 first_panel_shift_y+padding_y+(pos_step*y_row_position)+3 x_var_col_size y_var_row_size]);

    hEdit4 = uicontrol('Style','text', 'Position',[colmn_3_start+235 first_panel_shift_y+185 115 25], 'String','Time to run: 0');
    hEdit5 = uicontrol('Style','text', 'Position',[colmn_3_start+150 first_panel_shift_y+185 115 25], 'String','Time to run:');
%     [padding_x+200 first_panel_shift_y 100 20]
    set(hFig, 'Visible','on')        %# Make the GUI visible
    set(hEdit4, 'Visible','off')
    set(hEdit5, 'Visible','off')
%     running = true;
%     while running == true,
%     if get(get(hBtnGrp,'SelectedObject'),'Tag') == 'Model_1',
%         discription = disc_M1;
%         set(discription, 'Visible','on')
%     else
%         discription = None;
%         set(discription, 'Visible','off')
%     end
%     end
%     disp(get(get(hBtnGrp,'SelectedObject'),'Tag'))
    running_antecedent_vers=0;  % Including (=1) or not (=0) the antecedent variables in the DETECT model.
% runmodel=1;                 % Whether to run the model (=1) or not(=0).
Nt_run=183*4;               % The number of time steps the user wishes to run the DETECT model for. For 
                            % Ryan et al. (in review), max(Nt_run)=183*4, where 183 is the no. of days 
                            % model is run for and 4 is the no. of 6 hourly time-steps each day.
Nt_beg=92;                  % First DoY to use for computer experiment.
Nt_end=274;                 % Final DoY to use for computer experiment.
writefile=1;                % Whether to write the output to mat and csv files (=1) or not (=0).

% Read in the driving data and site data.  For Ryan et al. (in review), SWC (Soil Water Content) and SoilT 
% (Soil Temperature) are output from another model called HYDRUS which estimates these variables based on 
% measurements of SWC and SoilT at three depths at the site.  The AtmPress and Gness data are measured at 
% site.  Temporal gap-filling of these four sets of measurements were made
% for times of missing data.  The Nt and Nz refer to the number of time 

% save([pwd '/DETECT_Versions/Efficient_DETECT/Efficient_Outputs/output_6hourly' num2str(ant) '.mat'],'out')
Data = [];
load([pwd '/DETECT_Versions/Efficient_DETECT/Efficient_Inputs/PHACEdata_6hourly.mat'])  %Control treatment plot from PHACE site for 2008
SWC = Data.SWC;                %Nt * Nz
SoilT = Data.SoilT;            %Nt * Nz
SWCant_Rm = Data.SWCantRm;     %Nt * Nz * Nlag  (Nlag = 4 weeks in the past)
SWCant_Rr = Data.SWCantRr;     %Nt * Nz * Nlag  (Nlag = 4 weeks in the past)
SoilTant = Data.SoilTant;      %Nt * Nz * Nlag  (Nlag = 7 days in the past)
Gness = Data.Gness;            %Nt * 1
AtmPress = Data.AtmPress;      %Nt * 1
params_swp = Data.params_swp;  %Nz * 3
Xrel = Data.Xrel;              %Nz * 3
ic = Data.cinit;               %1 * Nz+1
d13Cr = Data.d13Cr;            %1 * Nz+1
d13Cm = Data.d13Cm;            %1 * Nz
dx = Data.dx;                  %1 * 2
BC = Data.BC;                  %Nt * 1    


% Parameters used by the DETECT model.  For a detailed description of the parameters, please see Ryan et al. 
% (in review).  Parameter values used are mostly taken from the following papers:
% Ryan et al. (2015) Antecedent moisture and temperature conditions modulate the response of ecosystem 
% respiration to elevated CO2 and warming
% Davidson et al. (2012) The Dual Arrhenius and Michaelis�Menten kinetics model for decomposition of soil 
% organic matter at hourly to seasonal time scales Tucker et al. (2012) Does declining carbon-use efficiency 
% explain thermal acclimation of soil respiration with warming?

%Additional parameters required for the Rr model:


% params(1) = 111.54;  % Rstar = total root biomass (mgC) mass in a one cm2 column of soil 1m deep. 
params(1) = str2double(get(param_1, 'String'));

% params(2) = 0.00006; % RrBase, mass-specific root respiration base rate at a tau degC (mgC cm-3 hr-1).
params(2) = str2double(get(param_2, 'String'));

% params(3) = 11.65;    % alpha1 for Rr; SWC param.   
params(3) = str2double(get(param_3, 'String'));

% params(4) = 20.72;   % alpha2 for Rr; The main effect of SWCant on the log-scaled Rrbase
params(4) = str2double(get(param_4, 'String'));

% params(5) = -164.16; % alpha3 for Rr; The main effect of SWC*SWCant on the log-scaled Rrbase
params(5) = str2double(get(param_5, 'String'));


%Parameters used by the Rm submodel.
% params(6) = 711.6094; % Cstar = total soil C (mgC) mass in a one cm2 column of soil 1m deep. 
params(6) = str2double(get(param_6, 'String'));

% params(7) = 12.2568;  % Mstar = total MBC (mgC) mass in a one cm2 column of soil 1m deep. 
params(7) = str2double(get(param_7, 'String'));

% params(8) = 0.0015;   % RmBase; (mg C cm-3 hr-1); based on value used in Davidson et al. (2012)
params(8) = str2double(get(param_8, 'String'));

% params(9) = 14.05;    % alpha1 (mg C cm-3 hr-1); based on value used in Ryan et al. (2015) 
params(9) = str2double(get(param_9, 'String'));

% params(10) = 11.05;    % alpha2; The main effect of SWCant on the log-scaled Rmbase;  
params(10) = str2double(get(param_10, 'String'));

% params(11) = -87.55;   % alpha3; The main effect of SWC*SWCant on the log-scaled Rmbase; 
params(11) = str2double(get(param_11, 'String'));

% params(12) = 0.00001; % Km
params(12) = str2double(get(param_12, 'String'));

% params(13) = 0.8;     % CUE; Carbon Use Efficiency (mgC/mgC).  Taken from Tucker et al. (2012) 
params(13) = str2double(get(param_13, 'String'));

% params(14) = 0.0004;  % solfrac; Fraction of substrate that Sx that is soluble (called 'p' in DAMM paper). 
params(14) = str2double(get(param_14, 'String'));

% params(15) = 3.17;    % Dliq; Diffusivity of substrate Sx that is liquid.  Dimensionless.
params(15) = str2double(get(param_15, 'String'));

% params(16) = 324.6;    % Eo_Rm; Eo term used in Rm submodel (Kelvin). Use value from Ryan et al. (2015)
params(16) = str2double(get(param_16, 'String'));

% params(17) = 324.6;   % Eo_Rr; Eo term used in Rr submodel (Kelvin); Use value from Ryan et al. (2015)
params(17) = str2double(get(param_17, 'String'));

% params(18) = 227.5;   % To; Temp. parameter used in the Lloyd & Taylor temp. (Kelvin)
params(18) = str2double(get(param_18, 'String'));

% params(19) = -4.67;    % alpha4; The main effect of SoilTant on the log-scaled Rmbase;
params(19) = str2double(get(param_19, 'String'));

% params(20) = 10;      % tau; Base temperature in Kelvin.  We use 10 degC.
params(20) = str2double(get(param_20, 'String'));



if (running_antecedent_vers==0)
    params(4) = 0; params(5) = 0; params(10) = 0; params(11) = 0; params(19) = 0; 
    ant=[''];
else
    ant=['_ant'];
end


% t1=clock;    %start time for model run.
%     [out info] = [];
%     t2=clock;
%Lag parameters.  The first row describes the importance of each of hte past
%4 days on Rm in Source term submodel.  The 2nd row describes the importance 
%of each of hte past 4 weeks on Rr in Source term submodel.
params_lag = [0.75 0.25 0 0; 
              0.2 0.6 0.2 0;
              0.25 0.25 0.25 0.25];  

%                 if get(get(hBtnGrp,'SelectedObject'),'Enable') == 'on',
%                     res = 'Status: Running...';
%                     set(hEdit3, 'String',res);
%                 end
% get(get(hBtnGrp,'SelectedObject'))
% set(hEdit3,'Enable','Status: Running...');    
    %# callback function
    function button_callback(src,ev)
        SWC = Data.SWC;                %Nt * Nz
        SoilT = Data.SoilT;            %Nt * Nz
        switch get(get(hBtnGrp,'SelectedObject'),'Tag')
            case 'Model_1',
                tic
                [out info] = DETECTmodel(Nt_run,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness,AtmPress,params_swp,Xrel,ic,d13Cr,d13Cm,dx,BC,params,params_lag);
                DayN=[(Nt_beg-1):0.25:Nt_end]';
                if (writefile==1)
                    save([pwd '/DETECT_Versions/Original_DETECT/Outputs/output_6hourly' num2str(ant) '.mat'],'out')
                    save([pwd '/DETECT_Versions/Original_DETECT/Outputs/info_6hourly' num2str(ant) '.mat'],'info')
                    myfile4 = fopen([pwd '/DETECT_Versions/Original_DETECT/Outputs/outCO2_6hourly' num2str(ant) '.csv'] ,'w+');
                    fprintf(myfile4,['DayN,' 'd0,' 'd1,' 'd2,' 'd3,' 'd4,' 'd5,' 'd6,' 'd7,' 'd8,' 'd9,' 'd10,' 'd11,' 'd12,' 'd13,' 'd14,' 'd15,' 'd16,' 'd17,' 'd18,' 'd19,' 'd20,' 'd21,' 'd22,' 'd23,' 'd24,' 'd25,' 'd26,' 'd27,' 'd28,' 'd29,' 'd30,' 'd31,' 'd32,' 'd33,' 'd34,' 'd35,' 'd36,' 'd37,' 'd38,' 'd39,' 'd40,'  'd41,' 'd42,' 'd43,' 'd44,' 'd45,' 'd46,' 'd47,' 'd48,' 'd49,' 'd50,'  'd51,' 'd52,' 'd53,' 'd54,' 'd55,' 'd56,' 'd57,' 'd58,' 'd59,' 'd60,'  'd61,' 'd62,' 'd63,' 'd64,' 'd65,' 'd66,' 'd67,' 'd68,' 'd69,' 'd70,'  'd71,' 'd72,' 'd73,' 'd74,' 'd75,' 'd76,' 'd77,' 'd78,' 'd79,' 'd80,'  'd81,' 'd82,' 'd83,' 'd84,' 'd85,' 'd86,' 'd87,' 'd88,' 'd89,' 'd90,'  'd91,' 'd92,' 'd93,' 'd94,' 'd95,' 'd96,' 'd97,' 'd98,' 'd99,' 'd100,\n']);
                    fclose(myfile4);
                    dlmwrite([pwd '/DETECT_Versions/Original_DETECT/Outputs/outCO2_6hourly' num2str(ant) '.csv'],[DayN out.CO2], '-append','precision', '%.3f');
                end
                res = ['Status: Done DETECT Original'];
                set(hEdit3, 'String',res)
                set(hEdit4, 'String',toc)
                set(hEdit4, 'Visible','on')
                set(hEdit5, 'Visible','on')
                if play_sound.Value == 1,
                    [y, Fs] = audioread([pwd '/Misc/finished.mp3']);
                    sound(y, Fs);
                end
            case 'Model_2',
                tic
                [out info] = Efficient_DETECTmodel(Nt_run,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness,AtmPress,params_swp,Xrel,ic,d13Cr,d13Cm,dx,BC,params,params_lag);
                DayN=[(Nt_beg-1):0.25:Nt_end]';
                if (writefile==1)
                    save([pwd '/DETECT_Versions/Efficient_DETECT/Efficient_Outputs/output_6hourly' num2str(ant) '.mat'],'out')
                    save([pwd '/DETECT_Versions/Efficient_DETECT/Efficient_Outputs/info_6hourly' num2str(ant) '.mat'],'info')
                    myfile4 = fopen([pwd '/DETECT_Versions/Efficient_DETECT/Efficient_Outputs/outCO2_6hourly' num2str(ant) '.csv'] ,'w+');
                    fprintf(myfile4,['DayN,' 'd0,' 'd1,' 'd2,' 'd3,' 'd4,' 'd5,' 'd6,' 'd7,' 'd8,' 'd9,' 'd10,' 'd11,' 'd12,' 'd13,' 'd14,' 'd15,' 'd16,' 'd17,' 'd18,' 'd19,' 'd20,' 'd21,' 'd22,' 'd23,' 'd24,' 'd25,' 'd26,' 'd27,' 'd28,' 'd29,' 'd30,' 'd31,' 'd32,' 'd33,' 'd34,' 'd35,' 'd36,' 'd37,' 'd38,' 'd39,' 'd40,'  'd41,' 'd42,' 'd43,' 'd44,' 'd45,' 'd46,' 'd47,' 'd48,' 'd49,' 'd50,'  'd51,' 'd52,' 'd53,' 'd54,' 'd55,' 'd56,' 'd57,' 'd58,' 'd59,' 'd60,'  'd61,' 'd62,' 'd63,' 'd64,' 'd65,' 'd66,' 'd67,' 'd68,' 'd69,' 'd70,'  'd71,' 'd72,' 'd73,' 'd74,' 'd75,' 'd76,' 'd77,' 'd78,' 'd79,' 'd80,'  'd81,' 'd82,' 'd83,' 'd84,' 'd85,' 'd86,' 'd87,' 'd88,' 'd89,' 'd90,'  'd91,' 'd92,' 'd93,' 'd94,' 'd95,' 'd96,' 'd97,' 'd98,' 'd99,' 'd100,\n']);
                    fclose(myfile4);
                    dlmwrite([pwd '/DETECT_Versions/Efficient_DETECT/Efficient_Outputs/outCO2_6hourly' num2str(ant) '.csv'],[DayN out.CO2], '-append','precision', '%.3f');
                end
                res = ['Status: Done DETECT Efficient'];
                set(hEdit3, 'String',res)
                set(hEdit4, 'String',toc)
                set(hEdit4, 'Visible','on')
                set(hEdit5, 'Visible','on')
                if play_sound.Value == 1,
                    [y, Fs] = audioread([pwd '/Misc/finished.mp3']);
                    sound(y, Fs);
                end
            case 'Model_3',
                SWC(:,:) = mean(SWC(:));
                SoilT(:,:) = mean(SoilT(:));
                tic
                [out info] = FAKE_SS_DETECTmodel(Nt_run,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness,AtmPress,params_swp,Xrel,ic,d13Cr,d13Cm,dx,BC,params,params_lag);
                DayN=[(Nt_beg-1):0.25:Nt_end]';
                if (writefile==1)
                    save([pwd '/DETECT_Versions/FAKE_SS_DETECT/FAKE_SS_Outputs/output_6hourly' num2str(ant) '.mat'],'out')
                    save([pwd '/DETECT_Versions/FAKE_SS_DETECT/FAKE_SS_Outputs/info_6hourly' num2str(ant) '.mat'],'info')
                    myfile4 = fopen([pwd '/DETECT_Versions/FAKE_SS_DETECT/FAKE_SS_Outputs/outCO2_6hourly' num2str(ant) '.csv'] ,'w+');
                    fprintf(myfile4,['DayN,' 'd0,' 'd1,' 'd2,' 'd3,' 'd4,' 'd5,' 'd6,' 'd7,' 'd8,' 'd9,' 'd10,' 'd11,' 'd12,' 'd13,' 'd14,' 'd15,' 'd16,' 'd17,' 'd18,' 'd19,' 'd20,' 'd21,' 'd22,' 'd23,' 'd24,' 'd25,' 'd26,' 'd27,' 'd28,' 'd29,' 'd30,' 'd31,' 'd32,' 'd33,' 'd34,' 'd35,' 'd36,' 'd37,' 'd38,' 'd39,' 'd40,'  'd41,' 'd42,' 'd43,' 'd44,' 'd45,' 'd46,' 'd47,' 'd48,' 'd49,' 'd50,'  'd51,' 'd52,' 'd53,' 'd54,' 'd55,' 'd56,' 'd57,' 'd58,' 'd59,' 'd60,'  'd61,' 'd62,' 'd63,' 'd64,' 'd65,' 'd66,' 'd67,' 'd68,' 'd69,' 'd70,'  'd71,' 'd72,' 'd73,' 'd74,' 'd75,' 'd76,' 'd77,' 'd78,' 'd79,' 'd80,'  'd81,' 'd82,' 'd83,' 'd84,' 'd85,' 'd86,' 'd87,' 'd88,' 'd89,' 'd90,'  'd91,' 'd92,' 'd93,' 'd94,' 'd95,' 'd96,' 'd97,' 'd98,' 'd99,' 'd100,\n']);
                    fclose(myfile4);
                    dlmwrite([pwd '/DETECT_Versions/FAKE_SS_DETECT/FAKE_SS_Outputs/outCO2_6hourly' num2str(ant) '.csv'],[DayN out.CO2], '-append','precision', '%.3f');
                end
                res = ['Status: Done DETECT FAKE SS'];
                set(hEdit3, 'String',res)
                set(hEdit4, 'String',toc)
                set(hEdit4, 'Visible','on')
                set(hEdit5, 'Visible','on')
%                 get(get(play_sound),'Value')
% play_sound.Value
                if play_sound.Value == 1,
                    [y, Fs] = audioread([pwd '/Misc/finished.mp3']);
                    sound(y, Fs);
                end
            case 'Model_4',
                tic
                [out info] = SS_DETECTmodel(Nt_run,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness,AtmPress,params_swp,Xrel,ic,d13Cr,d13Cm,dx,BC,params,params_lag);
                DayN=[(Nt_beg-1):0.25:Nt_end]';
                if (writefile==1)
                    save([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/output_6hourly' num2str(ant) '.mat'],'out')
                    save([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/info_6hourly' num2str(ant) '.mat'],'info')
                    myfile4 = fopen([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/outCO2_6hourly' num2str(ant) '.csv'] ,'w+');
                    fprintf(myfile4,['DayN,' 'd0,' 'd1,' 'd2,' 'd3,' 'd4,' 'd5,' 'd6,' 'd7,' 'd8,' 'd9,' 'd10,' 'd11,' 'd12,' 'd13,' 'd14,' 'd15,' 'd16,' 'd17,' 'd18,' 'd19,' 'd20,' 'd21,' 'd22,' 'd23,' 'd24,' 'd25,' 'd26,' 'd27,' 'd28,' 'd29,' 'd30,' 'd31,' 'd32,' 'd33,' 'd34,' 'd35,' 'd36,' 'd37,' 'd38,' 'd39,' 'd40,'  'd41,' 'd42,' 'd43,' 'd44,' 'd45,' 'd46,' 'd47,' 'd48,' 'd49,' 'd50,'  'd51,' 'd52,' 'd53,' 'd54,' 'd55,' 'd56,' 'd57,' 'd58,' 'd59,' 'd60,'  'd61,' 'd62,' 'd63,' 'd64,' 'd65,' 'd66,' 'd67,' 'd68,' 'd69,' 'd70,'  'd71,' 'd72,' 'd73,' 'd74,' 'd75,' 'd76,' 'd77,' 'd78,' 'd79,' 'd80,'  'd81,' 'd82,' 'd83,' 'd84,' 'd85,' 'd86,' 'd87,' 'd88,' 'd89,' 'd90,'  'd91,' 'd92,' 'd93,' 'd94,' 'd95,' 'd96,' 'd97,' 'd98,' 'd99,' 'd100,\n']);
                    fclose(myfile4);
                    dlmwrite([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/outCO2_6hourly' num2str(ant) '.csv'],[DayN out.CO2], '-append','precision', '%.3f');
                end
                res = ['Status: Done DETECT SS'];
                set(hEdit3, 'String',res)
                set(hEdit4, 'String',toc)
                set(hEdit4, 'Visible','on')
                set(hEdit5, 'Visible','on')
                if play_sound.Value == 1,
                    [y, Fs] = audioread([pwd '/Misc/finished.mp3']);
                    sound(y, Fs);
                end
             case 'Model_5',
                tic
%                 [out info] = SS_DETECTmodel(Nt_run,SWC,SoilT,SWCant_Rm,SWCant_Rr,SoilTant,Gness,AtmPress,params_swp,Xrel,ic,d13Cr,d13Cm,dx,BC,params,params_lag);
%                 DayN=[(Nt_beg-1):0.25:Nt_end]';
%                 if (writefile==1)
%                     save([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/output_6hourly' num2str(ant) '.mat'],'out')
%                     save([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/info_6hourly' num2str(ant) '.mat'],'info')
%                     myfile4 = fopen([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/outCO2_6hourly' num2str(ant) '.csv'] ,'w+');
%                     fprintf(myfile4,['DayN,' 'd0,' 'd1,' 'd2,' 'd3,' 'd4,' 'd5,' 'd6,' 'd7,' 'd8,' 'd9,' 'd10,' 'd11,' 'd12,' 'd13,' 'd14,' 'd15,' 'd16,' 'd17,' 'd18,' 'd19,' 'd20,' 'd21,' 'd22,' 'd23,' 'd24,' 'd25,' 'd26,' 'd27,' 'd28,' 'd29,' 'd30,' 'd31,' 'd32,' 'd33,' 'd34,' 'd35,' 'd36,' 'd37,' 'd38,' 'd39,' 'd40,'  'd41,' 'd42,' 'd43,' 'd44,' 'd45,' 'd46,' 'd47,' 'd48,' 'd49,' 'd50,'  'd51,' 'd52,' 'd53,' 'd54,' 'd55,' 'd56,' 'd57,' 'd58,' 'd59,' 'd60,'  'd61,' 'd62,' 'd63,' 'd64,' 'd65,' 'd66,' 'd67,' 'd68,' 'd69,' 'd70,'  'd71,' 'd72,' 'd73,' 'd74,' 'd75,' 'd76,' 'd77,' 'd78,' 'd79,' 'd80,'  'd81,' 'd82,' 'd83,' 'd84,' 'd85,' 'd86,' 'd87,' 'd88,' 'd89,' 'd90,'  'd91,' 'd92,' 'd93,' 'd94,' 'd95,' 'd96,' 'd97,' 'd98,' 'd99,' 'd100,\n']);
%                     fclose(myfile4);
%                     dlmwrite([pwd '/DETECT_Versions/SS_DETECT/SS_Outputs/outCO2_6hourly' num2str(ant) '.csv'],[DayN out.CO2], '-append','precision', '%.3f');
%                 end
                Rpath = 'D:\Programs\R\R_350\bin';
                RscriptFileName = 'D:\Research\DETECT_MatLab\DETECT_Versions\R_DETECT_NSS\DETECT_R_SCRIPT.R';
                RunRcode(RscriptFileName, Rpath); 

                res = ['Status: Done Rscript DETECT Efficient NSS'];
                set(hEdit3, 'String',res)
                set(hEdit4, 'String',toc)
                set(hEdit4, 'Visible','on')
                set(hEdit5, 'Visible','on')
                if play_sound.Value == 1,
                    [y, Fs] = audioread([pwd '/Misc/finished.mp3']);
                    sound(y, Fs);
                end
            otherwise, res = '';
        end
%         set(hEdit3, 'String',res)
    end
end