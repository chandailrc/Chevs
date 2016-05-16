function h = circle(x,y,r,t,c)
hold on
theta = 0:pi/50:2*pi;
xunit = r * cos(theta) + x;
yunit = r * sin(theta) + y;
h = plot(xunit, yunit,c,'LineWidth',t);
hold off
end

