function FilterDataFromFig()
    % extract data line from fig
    line=findobj(gca,'Type','line');
    
    for i=1:length(line)
        XData=get(line(i),'XData'); %get the x data
        YData=get(line(i),'YData'); %get the y data
        data.X=XData'; % row vector  
        data.Y=YData'; % row vetcor

        Data{i} = data;
    end

    all_yy = [];
    for i=1:length(Data)
        yy = smooth(Data{i}.Y);
        all_yy = [all_yy  yy];
    end

    plot(all_yy);


end