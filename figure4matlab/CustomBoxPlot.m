clear variables 
close all 
clc



%% global variable
variable_to_plot = 'metric3';
% title of the image
titl = 'Iteration of convergence ($m_3$)'; % Constraints violations % Best fitness % Distance from the optimal solution % Iteration of convergence 
title_dimension = 20;
labels_dimension = 20;
% y axis label
%y_lab = '$m_4$'; % euclidean distance from the optimal pi% sum of the constraints violations of the best solution %best fitness provided by the methods % iteration at which the fitness value converge %
% this vector specify wich element i want to plot from variable_to_plot
box_to_plot_selector =[2 3 6]; %[ 2 3 6]
name_file = 'g06_g07_g09_f240_f241_HB_';%g06_g07_g09_f240_f241_HB_ / RP_humanoid_bench_lbrsimple_RP_humanoid_bench_lbrsimple_more_constrained_
labels = {'g07' 'g09' 'HB'};%'RB1','RB2'; g06' 'g07' 'g09' 'f240' 'f241' 'HB
%colors = ['y','m','g','b']; % define the color of each box (inverse order)
colors  =[  1.0000 ,0.8276, 0;
            0.5862    0.8276    0.3103;
            0    0.5172    0.5862;
            0    1.0000    0.7586];
trasparency = 0.8;
widths = 0.5; % width of the box % 0.5 for rob experiments
space_between_box_in_a_group = 0.2;
space_between_groups =widths + 0.9;
line_thickness = 1;
median_line_thickness = 2.5;
% this parameters tune when we consider a box small. It is usefull when we
% want to apply a box even if the box is too thin to show the color
treshold_for_small_box = 0.001;
% i define with extension the value that i need to show the color of the
% box if the box is too small to show the color
extens =1.5;
%% path to dat file to open
%%  SAVE PATH
 % parameter
 folder = 'benckmark';
 %% IMP!!! this vector represents the order in which the istogram related to the i-th method is showed in the graph
 subfolder = {'(1+1)CMAES-vanilla','CMAES-vanilla','CMAES-adaptive','fmincon-fmincon'};
 allpath=which('FindData.m');
 local_path=fileparts(allpath);
 
 
 %% LOAD DATA
 for i=1:length(subfolder)
    cur_mat = strcat(local_path,'/',folder,'/',subfolder{i},'/',name_file,'.mat');
    load(cur_mat,variable_to_plot);
    store_data{i} = eval(variable_to_plot);
 end
 
 
 %% create plot  
 % the hyphothesis is that each variable_to_plot come as matrix where the
 % lines are the box to plot while the columns are the elemnts of each box
 % plot
 % i make the hypothesis that the different matrix came with the same
 % amount of line but different column.
 
 % given the lenght of store_data and the number of element in box_to_plot_selector
 % we can compute the position for grouping the boxplot 
 len_store_data = length(store_data); % number of element per group
 len_box_to_plot_selector = length(box_to_plot_selector); % number of group
 
 
 step = widths + space_between_box_in_a_group;
 index = 1;
 pos = 1;
 for i=1:len_box_to_plot_selector
   for j = 0 : len_store_data-1
      positions(index) = pos + j*step;
      index = index + 1;
   end
   pos = pos + j*step + space_between_groups;
 end
 
%% create vector of data to plot and a the vector that specify to which box each value belong to
index = 1;
x = [];
group = [];
for i=1:len_box_to_plot_selector
   for j = 1:len_store_data
      x = [x store_data{j}{box_to_plot_selector(i)}];
      group = [group , index * ones(1,size(store_data{j},1))];
      index = index + 1;
   end
end

%% color box plot
% build the complete color vector
color_vec = [];
for i = 1:len_box_to_plot_selector
   color_vec = [color_vec; colors];
end

%% plot boxplot
h1 = boxplot(x,group, 'positions', positions,'widths',widths);
set(h1,{'linew'},{line_thickness});
%% set median boxplot
h = findobj(gca,'tag','Median');
set(h,'linewidth',median_line_thickness);
set(h,'Color',[0 0 0])

%% set label
% build the vector of mean position from positions 
index = 1;
for i = 1:len_box_to_plot_selector
   mean_pos(i) = mean(positions(index:(index + len_store_data - 1)));
   index = index + len_store_data;
end

%% label properties
set(get(gca,'Xticklabel'),'Interpreter','latex');
set(gca,'xtick',mean_pos)
set(gca,'xticklabel',labels)


%% patch display
h = findobj(gca,'Tag','Box');
h =  flipud(h);
for j=1:length(h)
   x = get(h(j),'XData');
   y = get(h(j),'YData');
   
   x = x(1:4);
   y = y(1:4);
   
   if(abs(y(2)-y(1))<treshold_for_small_box)
      ymean = (y(2)+y(1))/2;
      y = [ymean - extens, ymean + extens,ymean + extens, ymean - extens];
   end
   patch(x,y,color_vec(j,:),'FaceAlpha',trasparency,'LineStyle','none');
   
   
end

%% put the legend
hleg1 = legend('(1+1)CMAES ad. cov.','CMAES vanilla','CMAES adaptive','fmincon');%,'fmincon sqd');
set(hleg1,'Interpreter','Latex');
%ylabel(y_lab,'FontSize',labels_dimension,'Interpreter','latex');
set(gca,'FontSize',labels_dimension);
title(titl,'FontSize', title_dimension,'Interpreter','latex');
