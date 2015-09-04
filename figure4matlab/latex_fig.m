% font_size: ratio between the size of the font and the size of the graph
% number_font_size: dimension of the number on the graph
% latex_font_size: real font size
% axis_limit: 
% f_width: the figure width (in inches)
% f_height: the figure height (in inches)
% linewidth:
% linecolor:
% xlabel_pos: position of x label [ x y z] respect current position
% ylabel_pos: position of y label [ x y z] respect current position
% visibility: visibility of label x and y {'on', 'off'}
% grid_on control the presence of the grid. true or false

%sample usage
%  latex_fig(10,16,30,[0,20,-0.1,1.1],5, 1.5,'r',3,[0 0 0],[0.4 0 0],{'off','on'},false)

function latex_fig(font_size,number_font_size,latex_font_size,axis_limit,...
                   f_width,f_height,linecolor,linewidth,xlabel_pos,ylabel_pos,visibility,grid_on,leg_font_size,leg_line_width)
% axis handle
xlabh = get(gca,'XLabel');
ylabh = get(gca,'YLabel');

% legend handle
leg=findobj(gcf,'Type','axes','Tag','legend');

% se axis limit
axis(axis_limit)

% swith on or off the grid
if(grid_on)
    grid on
else
    grid off
end
% set line properties
line=findobj(gca,'Type','line');
for i=1:length(line)
set(line(i,1),'LineWidth',linewidth(1,i));
set(line(i,1),'Color',linecolor{1,i})
end

% set legend properties
if(isempty(leg) == 0)
    set(leg,'FontSize',leg_font_size);
    set(leg,'LineWidth',leg_line_width);
end
font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

% change position of label
set(xlabh,'Position',get(xlabh,'Position') + xlabel_pos)
set(ylabh,'Position',get(ylabh,'Position') + ylabel_pos)

% change visibility 
set(xlabh,'Visible',visibility{1});
set(ylabh,'Visible',visibility{2});

% change fontsize
set(xlabh,'FontSize',latex_font_size);
set(ylabh,'FontSize',latex_font_size);

% set the dimension of the number of the graph
set(gca,'fontsize',number_font_size);

% change background color to white
set(gcf,'color','w');

set(leg, 'box', 'on');