%
% SubList < 0 is whole list
%
txt_path = 'D:\Desktop\Main\val.txt';
det_path ='D:\Desktop\Main\';

txt_dir = importdata(txt_path);

fid_detTrain = fopen([det_path 'randVal.txt'],'w');
rand_list = randperm(length(txt_dir));
    
for i = 1:length(rand_list)
   fprintf(fid_detTrain, '%s\n', txt_dir{rand_list(i)});
end

fclose(fid_detTrain);