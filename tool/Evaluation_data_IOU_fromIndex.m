train_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\ImageSets\Main\train.txt';
val_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\ImageSets\Main\val.txt';
train_dir = importdata(train_path);
val_dir = importdata(val_path);

imgdir = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_train\clean_mask';
gtdir = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\seg';
IOUs = zeros(length(train_dir)+length(val_dir), 1);

for i= 1:length(train_dir)
    img = imread(fullfile(imgdir,[train_dir{i} '.png']));
    gt = imread(fullfile(gtdir,[train_dir{i} '.png']));
    img_index = find(img~=0);
    gt_index = find(gt~=0);
    IOUs(i) = length(intersect(img_index,gt_index))/length(union(img_index,gt_index));
    if(isnan(IOUs(i)))
        if isempty(gt_index)&& isempty(img_index)
            IOUs(i)=1;
        else
            IOUs(i)=0;
        end        
    end
    disp([num2str(i) ': ' num2str(IOUs(i))])
end

for i= (length(train_dir)+1):(length(train_dir)+length(val_dir))
    img = imread(fullfile(imgdir,[val_dir{i-length(train_dir)} '.png']));
    gt = imread(fullfile(gtdir,[val_dir{i-length(train_dir)} '.png']));
    img_index = find(img~=0);
    gt_index = find(gt~=0);
    IOUs(i) = length(intersect(img_index,gt_index))/length(union(img_index,gt_index));
    if(isnan(IOUs(i)))
        if isempty(gt_index)&& isempty(img_index)
            IOUs(i)=1;
        else
            IOUs(i)=0;
        end        
    end
    disp([num2str(i) ': ' num2str(IOUs(i))])
end
disp(['all data IOU: ' num2str(mean(IOUs))])
disp(['val data IOU: ' num2str(mean(IOUs(length(train_dir)+1:length(train_dir)+length(val_dir))))])