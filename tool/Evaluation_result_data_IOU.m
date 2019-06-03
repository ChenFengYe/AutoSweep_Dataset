gtdir = 'D:\Desktop\SubGeonetData\seg';
imgpath = 'D:\Desktop\SubGeonetData\Segmentation\';
imgdir = dir([imgpath '*.png']);
IOUs = zeros(length(imgdir), 1);
index_sets =[];
for i= 1:length(imgdir)    
    img = rgb2gray(imread(fullfile(imgpath,[imgdir(i).name(1:end-16) '_result_line.png'])));
    gt = imread(fullfile(gtdir,[imgdir(i).name(1:end-16) '.png']));
    img_index = find(img~=0);
    gt_index = find(gt~=0);
    
    gt_size = size(gt);
    img_size =size(img);
    if ~all(gt_size(1:2) == img_size(1:2))
        index_sets = [index_sets; i];
    end
    
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
mean(IOUs)