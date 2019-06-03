%
% SubList < 0 is whole list
%
seg_path = 'D:\Desktop\SmallObjectSnapData2CityScape\img\*.jpg';
txt_path = 'D:\Desktop\ObjectSnapData\Sub_Geonet_data\Sub_Geonet_ob_data_6class\ImageSets\';
sub_list = -1;
train_rate = 0.6;
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
   segPath = fullfile(segDir(i).folder, segDir(i).name);
   fprintf(fid_train, '%d\t%s\t%s\n', i, ['img/' segDir(i).name(1:end-4) '.jpg'], ['instanceIds/' segDir(i).name(1:end-4) '.png']);
end

for i = val_list
   segPath = fullfile(segDir(i).folder, segDir(i).name);
   fprintf(fid_val, '%d\t%s\t%s\n', i + length(train_list), ['img/' segDir(i).name(1:end-4) '.jpg'], ['instanceIds/' segDir(i).name(1:end-4) '.png']);
end
fclose(fid_train);
fclose(fid_val);
clear all