cube_labelpath = 'D:\Desktop\ObjectSnapData\XiaoData\MagicLeapSplit\seg\*.png';
clspath = 'D:\Desktop\ObjectSnapData\XiaoData\MagicLeapSplit\cls\';
instpath = 'D:\Desktop\ObjectSnapData\XiaoData\MagicLeapSplit\inst\';
class_num = 6;

labelDir = dir(cube_labelpath);

% parfor i = 1:length(labelDir)
for i = 1:length(labelDir)
    i
    labelPath = fullfile(labelDir(i).folder, labelDir(i).name);
    labelimg = imread(labelPath);
    
    GTcls.Segmentation = create_cls_segmentation(labelimg);
    GTcls.CategoiesPresent = unique(GTcls.Segmentation);
    GTcls.CategoiesPresent(GTcls.CategoiesPresent ==0)=[];
    GTcls.Boundaries = create_boundary(GTcls.Segmentation, GTcls.CategoiesPresent, class_num-1);
    save([clspath labelDir(i).name(1:end-4) '.mat'],'GTcls');

    
    [GTinst.Segmentation, GTinst.Categories] = create_inst_segmentation(labelimg);
    GTinst.Boundaries = create_boundary(GTinst.Segmentation, [1:length(GTinst.Categories)]', length(GTinst.Categories));
    save([instpath labelDir(i).name(1:end-4) '.mat'],'GTinst');    
end

function seg = create_cls_segmentation(img)
    seg = im2uint8(zeros(size(img,1), size(img,2)));
    for r = 1:size(img,1)
            for c = 1:size(img,2)
                seg(r,c) = get_Categorie(img(r,c,:));
            end
    end
end

function [seg,cate] = create_inst_segmentation(img)
    seg = zeros(size(img,1), size(img,2));    
    % Cube 
    [seg, count_cube] = set_instance(seg, img, 1, 0);
    cate = ones(1,count_cube);
    % Cubeface
    [seg, count_cubeface] = set_instance(seg, img, 2, length(cate));
    cate = [cate ones(1,count_cubeface)*2] ;
    % Cubeface
    [seg, count_cylinder] = set_instance(seg, img, 3, length(cate));
    cate = [cate ones(1,count_cylinder)*3] ;
    % Cubeface
    [seg, count_cylinderface] = set_instance(seg, img, 4, length(cate));
    cate = [cate ones(1,count_cylinderface)*4];
    % Grip
    [seg, count_grip] = set_instance(seg, img, 5, length(cate));
    cate = [cate ones(1,count_grip)*5]' ;
end

function [seg instNum_i] = set_instance(seg, img, class_i, inst_n)
    inst_indexs = 1:inst_n;
    for r = 1:size(img,1)
        for c = 1:size(img,2)
            if get_Categorie(img(r,c,:))==class_i
                seg(r,c) = img(r,c,1)/10 + inst_n;
                if ~ismember(seg(r,c),inst_indexs)
                    inst_indexs = [inst_indexs seg(r,c)];
                end
            end
        end
    end
    instNum_i = length(inst_indexs) - inst_n;
    new_index = unique(inst_indexs);
    
    for i = new_index(inst_n+1:end)
        [r, c] = find(new_index== i);
        if i ~= c
            seg(find(seg==i)) = c;
        end
    end
end

function boundarys = create_boundary(img, cate, classNum)
    rows = size(img, 1);
    cols = size(img, 2);

    % Init 
    for i = 1:classNum
        boundarys{i,1} = sparse(zeros(rows, cols));
    end
    
    if isempty(cate)
        boundarys = {};
        return;
    end
    
    % ExtractBoundary
    for i = cate()'
        [sparse_r,sparse_c] = find(img==i);
        v = ones(1, length(sparse_r));
        imbw = full(sparse(sparse_r, sparse_c, v, rows, cols));
        boundarys{i,1} = sparse(bwperim(imbw));
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

%{
=======
Dataset
=======

The dataset is bundled together in the directory 'dataset'. There are three subdirectories:
	o img
	This directory contains all the images
	
	o cls
	This directory contains category-specific segmentations and boundaries. There is one .mat file for
	each image. Each mat file contains a struct called GTcls with 3 fields:
		- GTcls.Segmentation is a single 2D image containing the segmentation. Pixels that belong to 
		category k have value k, pixels that do not belong to any category have value 0.
		- GTcls.Boundaries is a cell array. GTcls.Boundaries{k} contains the boundaries of the k-th category.
		These have been stored as sparse arrays to conserve space, so make sure you convert them to full arrays
		when you want to use them/visualize them, eg : full(GTcls.Boundaries{15})
		- GTcls.CategoriesPresent is a list of the categories that are present.
	
	o inst
	This directory contains instance-specific segmentations and boundaries. There is one mat file for each
	image. Each mat file contains a struct called GTinst with 3 fields:
		- GTinst.Segmentation is a single 2D image containing the segmentation. Pixels belonging to the
		i-th instance have value i.
		- GTinst.Boundaries is a cell array. GTinst.Boundaries{i} contains the boundaries of the i-th instance.
		Again, these are sparse arrays.
		- GTinst.Categories is a vector with as many components as there are instances. GTinst.Categories(i) is
		the category label of the i-th instance.
	
There are in addition two text files, train.txt and val.txt, containing the names (without the extension) of the 
train images and validation images respectively. (They are called val here instead of test to avoid confusion with 
PASCAL VOC's test images: all images have been drawn from VOC2011 Train/Val).
%}