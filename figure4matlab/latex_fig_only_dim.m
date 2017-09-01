%sample usage
%  latex_fig(10,16,30,[0,20,-0.1,1.1],5, 1.5,true,{'r'},3,{0 0 0},[0.4 0 0],[0.4 0 0],{'on','off'},false,5,5)

function latex_fig_only_dim(font_size,f_width,f_height)

    % axis handle
    xlabh = get(gca,'XLabel');
    ylabh = get(gca,'YLabel');
    % set interpreter
    set(xlabh,'Interpreter','latex');
    set(ylabh,'Interpreter','latex');
    font_rate=10/font_size;
    set(gcf,'Position',[100   200   round(f_width*font_rate*144)   round(f_height*font_rate*144)])

end