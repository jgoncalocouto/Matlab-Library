
function fileInfo = getfileinfo(filename)

%DOS STRING FOR "FILE CREATION" DATE
dosStr = char(strcat('dir /T:C', {' '}, filename));
[~,str] = dos(dosStr);
c = textscan(str,'%s');
fileInfo.CreationDate = c{1}{15};
fileInfo.CreationTime = datestr(...
    datenum(strcat(c{1}{16},{' '}, c{1}{17}), 'HH:MM AM'), 'HH:MM');
%DOS STRING FOR "FILE LAST MODIFIED" DATE
dosStr = char(strcat('dir /T:W', {' '}, filename));
[~,str] = dos(dosStr);
c = textscan(str,'%s');
fileInfo.ModifiedDate = c{1}{15};
fileInfo.ModifiedTime = datestr(...
    datenum(strcat(c{1}{16},{' '}, c{1}{17}), 'HH:MM AM'), 'HH:MM');
end
