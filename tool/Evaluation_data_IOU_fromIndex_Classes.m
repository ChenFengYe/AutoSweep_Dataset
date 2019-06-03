val_path = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\ImageSets\Main\val.txt';
val_dir = importdata(val_path);

imgdir = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\maskrcnn_mask_train\clean_mask';
gtdir = 'D:\Desktop\ObjectSnapData\7_ExperimentData\Rebuttal_Exper_Mask_RCN\seg';
IOUs = zeros(length(val_dir), 1);
labels = zeros(length(val_dir), 1);

for i= 1:length(val_dir)
    img = imread(fullfile(imgdir,[val_dir{i} '.png']));
    gt = imread(fullfile(gtdir,[val_dir{i} '.png']));
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
    
    label = unique(gt);
    if(size(label, 1) ~= 2)
        disp('error!')
    end
    labels(i) = label(2);
    
    disp([num2str(i) ': ' num2str(labels(i)) ' ' num2str(IOUs(i))])
end

disp(['val data IOU -- 1: ' ClassIOU(IOUs, labels, 1)]); 
disp(['val data IOU -- 2: ' ClassIOU(IOUs, labels, 2)]);
disp(['val data IOU -- 3: ' ClassIOU(IOUs, labels, 3)]);
disp(['val data IOU -- 4: ' ClassIOU(IOUs, labels, 4)]);
disp(['val data IOU     : ' );

function classIOU = ClassIOU(IOUs, labels, class)
if(class==0)
    classIOU = num2str(sum(IOUs)/size(IOUs,1));
else
    indexs = find(labels == class);
    classIOU = num2str(sum(IOUs(indexs))/size(indexs,1));
end
end
