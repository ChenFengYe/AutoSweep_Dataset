paths_1 = 'D:\Desktop\SubGeonetData\img\'
paths_2 = 'D:\Desktop\SubGeonetData\Segmentation\*.png'
% Resize file in path_2

paths2_dir = dir(paths_2);
count = 0;
for i=2:length(paths2_dir)
    i
    paths1_path = fullfile(paths_1,[paths2_dir(i).name(1:end-16) '.jpg']);
    if exist(paths1_path,'file')
        count = count +1;
        paths2_path = fullfile(paths2_dir(i).folder,paths2_dir(i).name);
        img_1 = imread(paths1_path);
        img_2 = imread(paths2_path);
        img_2 = changeColor(imresize(img_2, [size(img_1,1) size(img_1,2)], 'nearest'));
        imwrite(img_2, paths2_path);
    end
end


function img_result = changeColor(img)
    img_result = uint8(zeros([size(img) 3]));
    for r = 1:size(img,1)
        for w = 1:size(img,2)
            switch img(r,w)
                case 0
                case 1             
                    img_result(r,w,:) = [0, 0, 255];
                case 2
                    img_result(r,w,:) = [0, 255, 0];
                case 3
                    img_result(r,w,:) = [255, 0, 0];
                case 4
                    img_result(r,w,:) = [255, 255, 255];
                case 5
                    img_result(r,w,:) = [100, 100, 100];
            end
        end
    end
end