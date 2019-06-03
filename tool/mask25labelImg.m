path ='D:\Desktop\SubGeonetData\seg_old';
path_result ='D:\Desktop\SubGeonetData\seg';

imageDir = dir(path);


parfor i = 3:length(imageDir)
    count_cubo = 0;
    count_cufa = 0;
    count_cybo = 0;
    count_cyfa = 0;
    count_grip = 0;

    i-2
    imgPath = fullfile(imageDir(i).folder, imageDir(i).name);
    img = imread(imgPath);
    img_cubo = uint8(zeros(size(img,1),size(img,2)));
    img_cufa = uint8(zeros(size(img,1),size(img,2)));
    img_cybo = uint8(zeros(size(img,1),size(img,2)));
    img_cyfa = uint8(zeros(size(img,1),size(img,2)));
    img_grip = uint8(zeros(size(img,1),size(img,2)));
    
    for r = 1:size(img,1)
        for w = 1:size(img,2)
            if img(r,w,2)==0 && img(r,w,3)==255   % cubo
                img_cubo(r,w) = 1;
                count_cubo = count_cubo +1;
            elseif img(r,w,2)~=0 && img(r,w,3)==255   % cufa
                img_cufa(r,w) = 2;
                count_cufa = count_cufa +1;
            elseif img(r,w,2)==0 && img(r,w,3)==200   % cybo
                img_cybo(r,w) = 3;
                count_cybo = count_cybo +1;
            elseif img(r,w,2)~=0 && img(r,w,3)==200   % cyfa
                img_cyfa(r,w) = 4;
                count_cyfa = count_cyfa +1;
            elseif img(r,w,2)==0 && img(r,w,3)==150   % cyfa
                img_grip(r,w) = 5;
                count_grip = count_grip +1;
            end
        end
    end
    saveImg(img_cubo,path_result,imageDir(i).name, '_CuBo', count_cubo);
    saveImg(img_cufa,path_result,imageDir(i).name, '_CuFa', count_cufa);
    saveImg(img_cybo,path_result,imageDir(i).name, '_CyBo', count_cybo);
    saveImg(img_cyfa,path_result,imageDir(i).name, '_CyFa', count_cyfa);
    saveImg(img_grip,path_result,imageDir(i).name, '_Grip', count_grip);
end