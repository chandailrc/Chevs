clear all; close all; clc; 

img_dir = 'C:\Users\Equaltrace\Documents\MATLAB\libviso2\matlab\scripts';
% 
% imageNames = dir(fullfile(workingDir,'%06d','*.png'));
% imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(img_dir,'chevs.avi'));
outputVideo.FrameRate = 10;
open(outputVideo)

for ii = 1:154
   img = imread([img_dir '/' num2str(ii,'%06d') '.png']);
   writeVideo(outputVideo,img)
end

close(outputVideo)