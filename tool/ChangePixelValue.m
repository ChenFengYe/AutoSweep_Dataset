paths_2 = 'D:\Desktop\SubGeonetData\temp\*.png'
% Resize file in path_2

paths2_dir = dir(paths_2);
for i=1:length(paths2_dir)
    i
    paths2_path = fullfile(paths2_dir(i).folder,paths2_dir(i).name);
    img_2 = changeColor(imread(paths2_path));
    imwrite(img_2, paths2_path);
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