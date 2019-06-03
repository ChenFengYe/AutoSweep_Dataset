paths_1 = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_DCN_train\img\*.jpg'
paths_2 = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\seg\'
% delete file in path_1

paths1_dir = dir(paths_1);
count = 0;
for i=1:length(paths1_dir)
    i
    paths2_path = fullfile(paths_2,[paths1_dir(i).name(1:end-4) '.png']);
    if exist(paths2_path,'file')
    else
        count = count +1;
%         delete(fullfile(paths1_dir(i).folder,paths1_dir(i).name))
    end
end
