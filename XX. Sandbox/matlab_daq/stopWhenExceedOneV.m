function stopWhenExceedOneV(src, event, data)
    
%     if any(event.Data > 1.0)
%         disp('Event listener: Detected voltage exceeds 1, stopping acquisition')
%         % Continuous acquisitions need to be stopped explicitly.
%         %src.stop()
%         plot(event.TimeStamps, event.Data)
%     else
%         disp('Event listener: Continuing to acquire')
%     end

    data.bufTime.append(event.TimeStamps);
    data.bufData.append(event.Data(:, 1));
    
    %plot(event.TimeStamps, event.Data)
    ttime = data.bufTime.getLast(10000);
    tdata = data.bufData.getLast(10000);
    
    hold on;
    %plot( ttime, tdata);
    
    plot( (event.TimeStamps), event.Data(:, 1));
     plot( (event.TimeStamps), event.Data(:, 2));   
     plot( (event.TimeStamps), event.Data(:, 3));  
     plot( (event.TimeStamps), event.Data(:, 4));
    hold off
    
    axis([ttime(1) ttime(10000) -inf inf]);
    
    disp('Event listener: Continuing to acquire')
end
