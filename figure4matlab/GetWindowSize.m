function [coz] = GetWindowSize()

 res=get(gcf,'Position');
 
 w = res(1,3)/144;
 h = res(1,4)/144;
 
 coz = [w , h];

end