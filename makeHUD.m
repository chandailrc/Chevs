%% VO
disp('===========================');
clear; close all; dbstop error; clc;


img_dir     = 'C:\Users\Equaltrace\Downloads\Data\2011_09_26\2011_09_26_drive_0005_sync\image_00\data';

param.f      = 721.5;
param.cu     = 609.5;
param.cv     = 172.8;
param.height = 1.6;
param.pitch  = -0.08;
first_frame  = 0;
last_frame   = 153;

%% Save png
savepng = 1;

%% Create AVI object
makemovie = 0;
if(makemovie)
    vidObj = VideoWriter('Output.avi');
    vidObj.Quality = 100;
    vidObj.FrameRate = 10;
    open(vidObj);
end

% % init visual odometry
% visualOdometryMonoMex('init',param);

% init transformation matrix array
% Tr_total{1} = eye(4);

% create figure
fid = figure('Color',[1 1 1]);
ha1 = axes('Position',[0.05,0.7,0.9,0.25]);
axis off;
ha2 = axes('Position',[0.05,0.05,0.9,0.6]);
set(gca,'XTick',-500:10:500);
set(gca,'YTick',-500:10:500);
axis equal, grid on, hold on;

% figure posns
size = 4;
cxSlipC = -5;
cySlipC = 0; 
cxChev = 0;
cyChev = 0; 

    NN = last_frame - first_frame + 1;
    S = dir('C:\Users\Equaltrace\Downloads\Data\2011_09_26\2011_09_26_drive_0005_sync\oxts\data');
    dname='C:\Users\Equaltrace\Downloads\Data\2011_09_26\2011_09_26_drive_0005_sync\oxts\data';
    for i = 3:NN+2
          myfilename = sprintf(S(i).name);
          gt_raw{i-2} = load(fullfile(dname,myfilename));
    end
    for i = 1:NN
        accelx(i) = gt_raw{i}(12);
        accely(i) = gt_raw{i}(13);
    end
    mAx = max(accelx);
    mAy = max(accely);
for frame=first_frame:last_frame
  
  % 1-based index
  k = frame-first_frame+1;
  
  % read current images
  I = imread([img_dir '/' num2str(frame,'%010d') '.png']);

 
  % accumulate egomotion, starting with second frame

  % update image
  axes(ha1); cla;
  imagesc(I); colormap(gray);
  axis off;
  
  % update trajectory
  axes(ha2);
  Accel = [gt_raw{k}(13), gt_raw{k}(12)]; % lateralaccel (turning), longitudinal (pedal) 1-->10 rn.
    % upcoming information for chevrons
    danger = [ 1 1 2 3]; % danger distribution [near soon far] 1-3 least --> most
    turn =   0;  % -2 hard left. -1 left. 0 straight. 1 right. 2 hard right.
    % draw everything
    axis equal
    axis off
    CHEVRONS(danger,turn,cxChev,cyChev,size)
    INTERFACE(Accel,cxSlipC,cySlipC,size)
    hold on;
    annotation('textbox',...
    [0.40 0.58 0.20 0.10],...
    'String',{['Accel Y = ' num2str(gt_raw{k}(13), '%0.4f')],['Accel X = ' num2str(gt_raw{k}(12),'%0.4f')]},...
    'FontSize',8,...
    'FontName','Arial',...
    'LineStyle','--',...
    'EdgeColor',[1 1 0],...
    'LineWidth',2,...
    'BackgroundColor',[0.9  0.9 0.9],...
    'Color',[0.84 0.16 0]);
    if (savepng) saveas(fid,sprintf('%06d.png',k)); end
    %superimpose dials on image with some sort of black section possibly
    %save image  
    if (makemovie) writeVideo(vidObj, getframe(gca)); end

  pause(0.05); refresh;

  % output statistics
    hold off;
end
if (makemovie) close(vidObj); end




%% Make HUD



% NFRAMES = 446; 
% path = '2011_09_26_drive_0009_sync/image_03/data/0000000';
% filetype = '.png';
% for n = 0:1:NFRAMES
%     filename = '000.png';
%     numStr = n; 
%     A = imread(strcat(path,filename))


%FIGURE DRAW LOOP
    %rear a frame of data
    % current traction outlook from raw acceleration in KITTI data
    
    %{
    close all
    axis equal
    axis off
    Accel = [5, 7];
    turn =   -1;
    danger = [ 1 2 2 3];
    CHEVRONS(danger,turn,cxChev,cyChev,size)
    INTERFACE(Accel,cxSlipC,cySlipC,size)
    pause(1)
    
    close all
    axis equal
    axis off
    Accel = [5, -7];
    turn =   1;
    danger = [ 1 2 2 3];
    CHEVRONS(danger,turn,cxChev,cyChev,size)
    INTERFACE(Accel,cxSlipC,cySlipC,size)
% %END FIGURE DRAW LOOP
    %}
