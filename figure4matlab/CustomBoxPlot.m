clear all 
close all 
clc

%% global variable
variable_to_plot = 'G_best_difference_performance';
box_to_plot_selector =[2 3 6]; % this vector specify wich element i want to plot from variable_to_plot
labels = {'g07','g09','HB'};
colors = ['y','m','b']; % define the color of each box (inverse order)
widths = 0.5; % width of the box
space_between_box_in_a_group = 0.2;
space_between_groups =widths + 0.5;
%% path to dat file to open
%%  SAVE PATH
 % parameter
 folder = 'benckmark';
 subfolder = {'CMAES-vanilla','CMAES-adaptive','(1+1)CMAES-vanilla'};
 allpath=which('FindData.m');
 local_path=fileparts(allpath);
 
 %% LOAD DATA
 for i=1:length(subfolder)
    cur_mat = strcat(local_path,'/',folder,'/',subfolder{i},'/dat.mat');
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
      x = [x store_data{j}(:,box_to_plot_selector(i))'];
      group = [group , index * ones(1,size(store_data{j},1))];
      index = index + 1;
   end
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


%% color box plot
% build the complete color vector
color_vec = [];
for i = 1:len_box_to_plot_selector
   color_vec = [color_vec colors];
end

% i define with extension the value that i need to show the color of the
% box if the box is too small to show the color
extens = 0;
h = findobj(gca,'Tag','Box');
for j=1:length(h)
   x = get(h(j),'XData');
   y = get(h(j),'YData');
   
   x = x(1:4);
   y = y(1:4);
   
   if(abs(y(2)-y(1))<10)
      ymean = (y(2)+y(1))/2;
      y = [ymean - extens, ymean + extens,ymean + extens, ymean - extens];
   end
   patch(x,y,color_vec(j),'FaceAlpha',.8);
   
   
end

%% put the legend
hleg1 = legend('(1+1)CMAES Adapt. Cov.','CMAES adaptive','CMAES vanilla' );

