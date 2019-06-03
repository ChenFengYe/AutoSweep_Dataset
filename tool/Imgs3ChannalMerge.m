path_g_mask ='D:\Desktop\SubGeonetData\12342_mask_2\*.png';
path_r_line ='D:\Desktop\SubGeonetData\line';
path_b_gray ='D:\Desktop\SubGeonetData\gray';

path_result = 'D:\Desktop\SubGeonetData\img\';

imageDir_mask = dir(path_g_mask);
imageDir_gray = dir(path_b_gray);

errorList = [];
% if length(imageDir_mask) ~= length(imageDir_gray)
%     disp('error Image number!')
% end

for i = 1:length(imageDir_mask)
    i
    img_result = uint8([]);
    img_g_mask = imread(fullfile(imageDir_mask(i).folder, imageDir_mask(i).name));
    if (~exist(fullfile(path_r_line, [imageDir_mask(i).name(1:end-9) '.png']), 'file'))
        errorList = [errorList; imageDir_mask(i).name];
    end
        
    img_r_line = imread(fullfile(path_r_line, [imageDir_mask(i).name(1:end-9) '.png'])); 
    img_b_gray = imread(fullfile(path_b_gray, [imageDir_mask(i).name(1:end-9) '.png'])); 
    
    if(~all(size(img_r_line)==size(img_g_mask)))
        disp('error !!!');
    end
    img_result(:,:,1) = img_r_line;
    img_result(:,:,2) = img_g_mask;
    img_result(:,:,3) = img_b_gray;
    imwrite(img_result,[path_result imageDir_mask(i).name(1:end-4) '.jpg']);
end