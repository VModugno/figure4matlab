% font_size: ratio between the size of the font and the size of the graph
% number_font_size: dimension of the number on the graph
% latex_font_size: real font size
% axis_limit: 
% f_width: the figure width (in inches)
% f_height: the figure height (in inches)
% active_line : activate the lines properties (for graph only)
% linewidth:
% linecolor:
% xlabel_pos: position of x label [ x y z] respect current position
% ylabel_pos: position of y label [ x y z] respect current position
% visibility: visibility of label x and y {'on', 'off'}
% grid_on control the presence of the grid. true or false

%sample usage
%  latex_fig(10,16,30,[0,20,-0.1,1.1],5, 1.5,true,{'r'},3,{0 0 0},[0.4 0 0],[0.4 0 0],{'on','off'},false,5,5)

function latex_fig(font_size,number_font_size,latex_font_size,axis_limit,...
                   f_width,f_height,active_line,linecolor,linewidth,linestyle,xlabel_pos,ylabel_pos,visibility,grid_on,leg_font_size,leg_line_width)
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
if(active_line)
   % set line properties (for graph only)
   line=findobj(gca,'Type','line');
   if(~isempty(line)) % check if i have lines around
      for i=1:length(line)
         if(isempty(linewidth)==0)
            if(length(linewidth)==1)
               set(line(i,1),'LineWidth',linewidth);
            else
               set(line(i,1),'LineWidth',linewidth(1,i));
            end
         end
         if(isempty(linecolor)==0)
            set(line(i,1),'Color',linecolor{1,i})
         end
         if(isempty(linestyle)==0)
            set(line(i,1),'LineStyle',linestyle{1,i})
         end
      end
   end
end
% set legend properties
if(isempty(leg) == 0)
    set(leg,'FontSize',leg_font_size);
    set(leg,'LineWidth',leg_line_width);
end

% change position of label
set(xlabh,'Position',get(xlabh,'Position') + xlabel_pos)
set(ylabh,'Position',get(ylabh,'Position') + ylabel_pos)

% change fontsize
set(xlabh,'FontSize',latex_font_size);
set(ylabh,'FontSize',latex_font_size);

% change visibility 
set(xlabh,'Visible',visibility{1});
set(ylabh,'Visible',visibility{2});

% set the dimension of the number of the graph
set(gca,'fontsize',number_font_size);

font_rate=10/font_size;
set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

% change background color to white
set(gcf,'color','w');

set(leg, 'box', 'on');
