daqreset;
clear all;

bActive = 1;

devList = daq.getDevices;

daqSession = daq.createSession('ni');

daqSession.Rate = 10;
%daqSession.DurationInSeconds = 10;

data = CDaqData(10*3600);

daqSession.NotifyWhenDataAvailableExceeds = 10; %override 10 times/sec callback call
%daqSessions.IsNotifyWhenDataAvailableExceedsAuto = true; %reset to 10hz
daqSession.IsContinuous = true;

addAnalogInputChannel(daqSession,'cDAQ1Mod1','ai4','Voltage');



prepare(daqSession);

%data = daqSession.startForeground();

lh = addlistener(daqSession,'DataAvailable', @(src, event)stopWhenExceedOneV(src, event, data));
%lh = addlistener(daqSession,'DataAvailable', @plotData); 
%lh = addlistener(s,'DataAvailable', @(src,event) plot(event.TimeStamps, event.Data));

daqSession.startBackground;

%daqSession.wait(); %waits until aquisition completes;

while daqSession.IsRunning
    pause(0.5)
    fprintf('While loop: Scans acquired = %d\n', s.ScansAcquired)
    
    if bActive == 0
        daqSession.stop();
        disp('Event listener: Stopping to acquire')
    end
end

fprintf('Acquisition has terminated with %d scans acquired\n', s.ScansAcquired);


delete (lh);
delete (data);
release(daqSession);

%plot(data);