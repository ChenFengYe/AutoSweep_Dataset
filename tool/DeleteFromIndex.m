txt_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\ImageSets\train.txt';
img_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_DCN_train\img\'

txtdir = importdata(txt_path);
for i = 1:length(txtdir)
    path = [img_path txtdir{i} '.jpg']
    if(exist(path,'file'))
    else
%     delete([img_path sprintf('%05d',(txtdir(i))) '.png'])
        disp('xx');
%         delete([img_path txtdir{i} '.png'])
    end
end