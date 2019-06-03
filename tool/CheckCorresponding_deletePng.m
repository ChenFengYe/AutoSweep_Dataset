paths_1 = 'D:\Desktop\SubGeonetData\img\'
paths_2 = 'D:\Desktop\SubGeonetData\seg\*.png'
% delete file in path_2

paths2_dir = dir(paths_2);
count = 0;
for i=1:length(paths2_dir)
    i
    paths1_path = fullfile(paths_1,[paths2_dir(i).name(1:end-4) '.jpg']);
    if exist(paths1_path,'file')
    else
        count = count +1;
        delete(fullfile(paths2_dir(i).folder,paths2_dir(i).name))
    end
end
