function save_all_figures_to_directory(dir_name)
figlist=findobj('type','figure');
for i=1:numel(figlist)
    saveas(figlist(i),fullfile(dir_name,['figure' num2str(figlist(i)) '.fig']));
end
end