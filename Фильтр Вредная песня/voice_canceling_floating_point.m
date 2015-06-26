close all;
clear all;
clc;

%% 
filename = 'vrpesnia.mp3';
[data,sample_rate] = audioread(filename);
left_channel = data(:,1);
right_channel = data(:,2);
%%
load('numerator.mat');
filtered_left_channel = conv(left_channel,numerator);
filtered_right_channel = conv(right_channel,numerator);
filtered_data = [filtered_left_channel,filtered_right_channel];
filtered_data = filtered_data/max(abs(filtered_data));
%% 
new_filename = strrep(filename,'.mp3','_filtered_floating_point.wav');
audiowrite(new_filename,filtered_data,sample_rate);