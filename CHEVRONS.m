function CHEVRONS(danger,turn,cx,cy, size)
%_________________
% danger distribution [near soon far] 1-3 least --> most
% -2 hard left. -1 left. 0 straight. 1 right. 2 hard right.
%_________________
%define the colours of the chevrons
NCHEVRONS = 4;
chevronColours = ''; %size of this is the number of chevrons. 
for d=1:NCHEVRONS
    if danger(d) == 1 %low dangeris green
       chevronColours = strcat(chevronColours,'g');
    elseif danger(d) == 2 %medium danger yellow
        chevronColours = strcat(chevronColours,'y');
    elseif danger(d) == 3 %high danger red
        chevronColours = strcat(chevronColours,'r');
    end
end
%draw the black dial and background
hold on
set(gcf,'color','w');
pos = [cx-2 cy-2 size size];
%black circle
rectangle('Position',pos,'Curvature',[1 1],'FaceColor','black')
%arrows
xposns = [];
yStartPosns = [];
yEndPosns = [];
spacing=0.25;
yinc = (size-spacing)/NCHEVRONS -0.25;
lside=cx - size/2;
rside=cx + size/2;
%HARDCODED FOR 4 CHEVRONS. draw chevrons and road curves
yDefaultStart = [-1.15 -0.25 0.65 1.65];
yDefaultEnd = yDefaultStart+0.15;
rcx=0;rcy=0;

if turn == 0
    yStartPosns = yDefaultStart;
    yEndPosns = yDefaultEnd;
    xposns = [0 0 0 0];
    rectangle('Position',[-1 -2.5 2 5],'Curvature',[0 0],'EdgeColor','white','LineWidth',3)
elseif turn == -1 %slight left
    yStartPosns =  yDefaultStart - [0 1 1 1];
    yEndPosns = yDefaultEnd + [0 0.1 0.2 0];
    xposns = [0 -0.1 -0.4 -1.0];
    rectangle('Position',[-6 -4 5 6],'Curvature',[1 1],'EdgeColor','white','LineWidth',3)
    rectangle('Position',[-4 -5 5 8],'Curvature',[1 1],'EdgeColor','white','LineWidth',3)
elseif turn == 1 %slight right
    yStartPosns =  yDefaultStart - [0 1 1 1];
    yEndPosns = yDefaultEnd + [0 0.1 0.2 0];
    xposns = -1*[0 -0.1 -0.4 -1.0];
    rectangle('Position',[0.75 -4 4 6 ],'Curvature',[1 1],'EdgeColor','white','LineWidth',3)
    rectangle('Position',[-1 -4 4 6.5 ],'Curvature',[1 1],'EdgeColor','white','LineWidth',3)
end
limits = [-7 2 -2 2];
axis(limits)


%draw chevrons
for n=NCHEVRONS:-1:1
    arrow('start',[cx,yStartPosns(n)],'stop',[xposns(n) yEndPosns(n)],'width',0,'Length',50',...
          'FaceColor',chevronColours(n),'BaseAngle',30)%,'EdgeColor','yellow')
end

%outer circle
circle(cx,cy,size/2,5,'r')
hold off
end