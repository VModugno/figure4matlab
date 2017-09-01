close all
clear all
clc

x = -pi:.1:pi;
y = sin(x);
p = plot(x,y);
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'})
xlabel('-\pi \leq \Theta \leq \pi')
ylabel('sin(\Theta)')
title('Simulation Results')
text(-pi/4,sin(-pi/4),'\leftarrow sin(-\pi\div4)',...
     'HorizontalAlignment','left')
set(p,'Color','red','LineWidth',2)


% define the features of the image
latex_fig(10,16,30,[0,20,-0.1,1.1],5, 1.5,false,{'r'},3,{0 0 0},[0.4 0 0],[0.4 0 0],{'on','off'},false,5,5)
