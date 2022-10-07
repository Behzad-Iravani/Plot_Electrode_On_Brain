
% Plot the electrodes on the MNI brain template 
clear all; clc; close all;
% read surface files 
[cortex.left.vert,  cortex.left.tri]= read_surf('surface\lh.pial'); % read mesh for left hemi
[cortex.right.vert, cortex.right.tri]= read_surf('surface\rh.pial'); % read mesh for left hemi
% add 1 to tri to fix indexing problem
cortex.left.tri = cortex.left.tri+1;
cortex.right.tri = cortex.right.tri+1;
% load an example MNI electrodes
load Electrodes.mat
% plot settings
hemi = 'left';
viewside = 'ventral';
% plot brain 
ctmr_gauss_plot(cortex.left,[T.X,T.Y,T.Z],zeros(height(T),1)', hemi, viewside)
hold on 
col = [1 0 0];
type = 'close'; % open or close
plot_electrodes_projected_to_brain([T.X,T.Y,T.Z],...
    cortex.(hemi).vert, num2cell(hemi,2),...
    viewside, T.JPAnatomy, 30, col, type)
