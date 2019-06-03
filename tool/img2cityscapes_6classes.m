cube_labelpath = 'D:\Desktop\ObjectSnapData\Synthtic_Data_21467\all\seg\*.png';
instpath = 'D:\Desktop\ObjectSnapData\Synthtic_Data_21467\all\instanceIds\';
class_num = 6;

labelDir = dir(cube_labelpath);

parfor i = 1:length(labelDir)
    i
    labelPath = fullfile(labelDir(i).folder, labelDir(i).name);
    labelimg = imread(labelPath);
    [Segmentation, Categories] = create_inst_segmentation(labelimg);
    imwrite(Segmentation,[instpath labelDir(i).name(1:end-4) '.png']);
end

function [seg,cate] = create_inst_segmentation(img)
    seg = uint16(zeros(size(img,1), size(img,2)));
    % Cube 
    [seg, count_cube] = set_instance(seg, img, 1);
    cate = ones(1,count_cube);
    % Cubeface
    [seg, count_cubeface] = set_instance(seg, img, 2);
    cate = [cate ones(1,count_cubeface)*2] ;
    % Cubeface
    [seg, count_cylinder] = set_instance(seg, img, 3);
    cate = [cate ones(1,count_cylinder)*3] ;
    % Cubeface
    [seg, count_cylinderface] = set_instance(seg, img, 4);
    cate = [cate ones(1,count_cylinderface)*4];
    % Grip
    [seg, count_grip] = set_instance(seg, img, 5);
    cate = [cate ones(1,count_grip)*5]' ;
end

function [seg instNum_i] = set_instance(seg, img, class_i)
    inst_indexs = [];
    for r = 1:size(img,1)
        for c = 1:size(img,2)
            if get_Categorie(img(r,c,:))==class_i
                seg(r,c) = (class_i*1000)+uint16(img(r,c,1)/10);
                if ~ismember(seg(r,c),inst_indexs)
                    inst_indexs = [inst_indexs seg(r,c)];
                end
            end
        end
    end
    instNum_i = length(inst_indexs);
    new_index = unique(inst_indexs);
    
    for i = new_index(1:end)
        [r, c] = find(new_index== i);
        if i ~= (class_i*1000)+c
            seg(find(seg==i)) = (class_i*1000)+c;
        end
    end
end

function cate = get_Categorie(pixel)
    if  pixel(2)==0 && pixel(3) ==255       % body Categories_1
        cate = 1;
    elseif pixel(2)~=0 && pixel(3) ==255    % face && Cube  Categories_2
        cate = 2;
    elseif pixel(2)==0 && pixel(3) ==200    % body Categories_2
        cate = 3;       
    elseif pixel(2)~=0 && pixel(3) ==200    % face && Cylinder  Categories_4
        cate = 4;        
    elseif pixel(2)==0 && pixel(3) ==150    % grip && Cylinder  Categories_5
        cate = 5;        
    else
        cate = 0;
    end
end