clear variables 
close all 
clc



%% global variable
variable_to_plot = 'metric2';
% title of the image
titl = 'Constraint violations';
title_dimension = 20;
label_dimension = 15;
% y axis label
y_lab = 'sum of the constraints violations of the best solution';
% this vector specify wich element i want to plot from variable_to_plot
box_to_plot_selector =[1 2];
name_file = 'RP_humanoid_bench_lbrsimple_RP_humanoid_bench_lbrsimple_more_constrained_';
labels = {'robotics exp 1','robotics experiment 2'};
colors = ['y','m','g']; % define the color of each box (inverse order)
trasparency = 0.8;
widths = 0.5; % width of the box
space_between_box_in_a_group = 0.2;
space_between_groups =widths + 0.9;
% this parameters tune when we consider a box small. It is usefull when we
% want to apply a box even if the box is too thin to show the color
treshold_for_small_box = 0.001;
% i define with extension the value that i need to show the color of the
% box if the box is too small to show the color
extens = 0.005;
%% path to dat file to open
%%  SAVE PATH
 % parameter
 folder = 'benckmark';
 %% IMP!!! this vector represents the order in which the istogram related to the i-th method is showed in the graph
 subfolder = {'(1+1)CMAES-vanilla','CMAES-vanilla','CMAES-adaptive'};
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
   color_vec = [color_vec colors];
end

%% plot boxplot
boxplot(x,group, 'positions', positions,'widths',widths);

%% set label
% build the vector of mean position from positions 
index = 1;
for i = 1:len_box_to_plot_selector
   mean_pos(i) = mean(positions(index:(index + len_store_data - 1)));
   index = index + len_store_data;
end

set(gca,'xtick',mean_pos)
set(gca,'xticklabel',labels)


% %% color box plot
% % build the complete color vector
color_vec = [];
for i = 1:len_box_to_plot_selector
   color_vec = [color_vec colors];
end


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
   patch(x,y,color_vec(j),'FaceAlpha',trasparency,'LineStyle','none');
   
   
end

%% put the legend
hleg1 = legend('(1+1)CMAES ad. cov.','CMAES vanilla','CMAES adaptive');%,'fmincon sqd');
ylabel(y_lab,'FontSize', label_dimension);
title(titl,'FontSize', title_dimension);

