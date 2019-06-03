%
% SubList < 0 is whole list
%
seg_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_DCN_Rcnn_Edge_train\seg\*.png';
txt_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_DCN_Rcnn_Edge_train\ImageSets\Main\';
sub_list = -1;
train_rate = 0.92;
segDir = dir(seg_path);


fid_train = fopen([txt_path 'train.txt'],'w');
fid_val = fopen([txt_path 'val.txt'],'w');
rand_list = randperm(length(segDir));
if sub_list <0
    sub_list = length(segDir);
end
    
train_list = sort(rand_list(1:floor(sub_list*train_rate)));
val_list =  sort(rand_list(floor(sub_list*train_rate)+1:sub_list));
for i = train_list
   fprintf(fid_train, '%s\n', segDir(i).name(1:end-4));
end

for i = val_list
   fprintf(fid_val, '%s\n', segDir(i).name(1:end-4));
end
fclose(fid_train);
fclose(fid_val);
clear all