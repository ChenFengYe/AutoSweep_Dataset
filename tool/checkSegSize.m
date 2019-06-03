img_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_DCN_Rcnn_Edge_train\img\'
seg_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_DCN_Rcnn_Edge_train\seg\'

segDir = dir(seg_path);
index_sets = []
max_rate = 0;
parfor i = 3:length(segDir)
   i
   imgPath = fullfile(img_path, [segDir(i).name(1:end-4) '.jpg']);
   segPath = fullfile(seg_path, [segDir(i).name]);
   img = imread(imgPath);
   seg = imread(segPath);  
   img_size = size(imread(imgPath));   
   seg_size = size(imread(segPath));

   cur_rate = max(img_size(2)/img_size(1),img_size(1)/img_size(2));
   max_rate = max(cur_rate, max_rate);
   if ~all(seg_size(1:2) == img_size(1:2))
       segPath
       index_sets = [index_sets; i];
   end
end
max_rate