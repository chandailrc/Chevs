function INTERFACE(Accel,cx,cy,size)
%___________________________________
%NOTE: needs a figure to draw into. cx,cy are center coords.
%___________________________________
%draw the traction circle
MAXACCEL = 2; %CONSTANT FROM DATA
AscaleX = (size/2)/MAXACCEL; %INPUT 
AscaleY = (size/2)/MAXACCEL; %INPUT
%calculate the drawing coords from raw data
AccPedal = Accel(1)*AscaleY;
AccSteer = Accel(2)*AscaleX;
hold on
pos = [cx-2 cy-2 size size];
%black circle
rectangle('Position',pos,'Curvature',[1 1],'FaceColor','black')
%outer circle
circle(cx,cy,size/2,5,'r')
%arrow
arrow('start',[cx,cy],'stop',[cx+AccPedal,cy+AccSteer],'width',5,'Length',20','FaceColor','w')
hold off
end
