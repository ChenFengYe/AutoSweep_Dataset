path1 ='D:\Desktop\Cylinder_dataset\muliticylinder_seg';
path2 ='D:\Desktop\Cylinder_dataset\Face';
% change image in path 1
imageDir1 = dir(path1);
imageDir2 = dir(path2);
count0 = 0;

if length(imageDir1) ~= length(imageDir2)
    disp('error Image number!')
end

parfor i = 3:length(imageDir1)
    i-2
    imgPath1 = fullfile(imageDir1(i).folder, imageDir1(i).name);
    img1 = imread(imgPath1);
    
    imgPath2 = fullfile(imageDir2(i).folder, [imageDir1(i).name(10:end-4) '_face.png']);
    if ~exist(imgPath2,'file')
        continue;
    end
    img2 = imread(imgPath2);
    
    for r = 1:size(img1,1)
        for w = 1:size(img1,2)
            if all(img2(r,w,:) ~= [0,0,0])
                img1(r,w,:) = img2(r,w,:);
                count0 = count0 + 1;
            end
        end
    end
    imwrite(img1,[path1 '\' imageDir1(i).name]);
end