function CancelLegendEntry()

   not_d = true;
   not_close = true;
   prompt = 'with edit plot activated click on the graph that you want to remove from the legend and then press d. for closing press q:  ';

   while(not_close)

      while(not_d)
         str = input(prompt,'s');
         if (strcmp(str,'d') == 1)
             not_d = false;
         elseif(strcmp(str,'q') == 1)
            not_d = false;
            not_close = false;
         end

      end
      if(not_close)
         hasbehavior(gco, 'legend', false)
         legend('-DynamicLegend');
      end
      not_d = true;

   end

end