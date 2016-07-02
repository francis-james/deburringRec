% Program for generating the plots for apdm and optitrack reading together
clc;
clear;
close all;
[apdm_file,apdm_file_path] = uigetfile('*.csv','Select the csv data file generated from APDM Software');
apdm_matrix = dlmread(strcat(apdm_file_path,apdm_file),',',1,1);
[labview_file,labview_file_path] = uigetfile('*.csv','Select the csv file generated from LabVIEW');
labview_matrix = dlmread(strcat(labview_file_path,labview_file),',');
labview_time_vector = labview_matrix(:,2);
apdm_time_vector = apdm_matrix(:,2);
apdm_matrix = apdm_matrix(:,18:end);



%% plotting values index
apdm_idx = 3;
force_idx = 5;
opti_idx = 9;
skipping_value = 200;
skipping_value_for_optitrack = 200;
% matching apdm z acceleration with opti-track y direction motion
apdm_first_reading = abs(apdm_matrix(skipping_value,apdm_idx));
opti_first_reading = abs(labview_matrix(skipping_value_for_optitrack,opti_idx));
threshold_apdm = 0.1;
threshold_opti = 0.001;
[~,apdm_change_index] = max(abs(apdm_first_reading-abs(apdm_matrix(skipping_value:end,apdm_idx))) > threshold_apdm);
[~,opti_change_index] = max(abs(opti_first_reading-abs(labview_matrix(skipping_value_for_optitrack:end,opti_idx))) > threshold_opti);
apdm_change_index = apdm_change_index + skipping_value;
opti_change_index = opti_change_index + skipping_value_for_optitrack;
apdm_matrix = apdm_matrix(apdm_change_index:end,:);
labview_matrix = labview_matrix(opti_change_index:end,:);
labview_time_vector = (labview_time_vector(opti_change_index:end,:) - labview_time_vector(opti_change_index,:)) / 1000.00;
apdm_time_vector = (apdm_time_vector(apdm_change_index:end,:) - apdm_time_vector(apdm_change_index,:))/1000000.00;

figure
s_1 = subplot(4,1,1);
plot(apdm_time_vector,apdm_matrix(:,apdm_idx));
grid minor
ylabel('acceleration in m/s^2','FontSize', 15);
s_2 = subplot(4,1,2);
plot(labview_time_vector,labview_matrix(:,opti_idx));
ylabel('position in meters','FontSize', 15);
grid minor
s_3 = subplot(4,1,3);
plot(labview_time_vector,labview_matrix(:,force_idx));
ylabel('Force in Newtons','FontSize', 15);
grid minor
mag_a = sqrt(apdm_matrix(:,3).^2 + apdm_matrix(:,4).^2 + apdm_matrix(:,5).^2);
s_4 = subplot(4,1,4);
plot(apdm_time_vector,mag_a);
ylabel('magnitude in m/s^2','FontSize', 15);
grid minor

linkaxes([s_1,s_2,s_3,s_4],'x');
xlabel('time in seconds','FontSize', 15);


