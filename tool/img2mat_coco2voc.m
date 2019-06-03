seg_path = 'D:\Desktop\png fix\seg\*.png';
clspath = 'D:\Desktop\png fix\cls\';
instpath = 'D:\Desktop\png fix\inst\';
% seg_path = 'D:\Desktop\test\emf\*.png';
% clspath = 'D:\Desktop\test\cls\';
% instpath = 'D:\Desktop\test\inst\';

class_num = 5;

labelDir = dir(seg_path);

for i = 1:length(labelDir)
    i
    labelPath = fullfile(labelDir(i).folder, labelDir(i).name);
    labelimg = imread(labelPath);
    % fix white problem
    for r = 1:size(labelimg,1)
        if all(reshape(labelimg(r,1,:),[],3)==[255 255 255])
            labelimg(r,1,:)=[0 0 0];
        end
    end
    for c = 1:size(labelimg,2)
        if all(reshape(labelimg(1,c,:),[],3)==[255 255 255])
            labelimg(1,c,:)=[0 0 0];
        end
    end
    
    % create GTcls
    GTcls.Segmentation = create_cls_segmentation(labelimg);
    GTcls.CategoiesPresent = unique(GTcls.Segmentation);
    GTcls.CategoiesPresent(GTcls.CategoiesPresent ==0)=[];
    GTcls.Boundaries = create_boundary(GTcls.Segmentation, GTcls.CategoiesPresent, 1);
    save([clspath labelDir(i).name(1:end-4) '.mat'],'GTcls');
    
    % create GTcls
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
inst_color = unique(reshape(img,[],3),'rows');
seg = zeros(size(img,1), size(img,2));
for r = 1:size(img,1)
    for c = 1:size(img,2)
        for i = 1:size(inst_color,1)
            %             if ~all(img(r,c,:) ==[0 0 0])
            %                 disp('x');
            %             end
            if all(reshape(img(r,c,:),[],3)==inst_color(i,:))
                seg(r,c)=i-1;
            end
        end
    end
end
cate = ones(1,size(inst_color,1)-1)';
end

function boundarys = create_boundary(img, cate, classNum)
rows = size(img, 1);
cols = size(img, 2);

% ExtractBoundary
for i = cate()'
    [sparse_r,sparse_c] = find(img==i);
    v = ones(1, length(sparse_r));
    imbw = full(sparse(sparse_r, sparse_c, v, rows, cols));
    if ~any(imbw(:))
        disp('Stop!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
    end
    boundarys{i,1} = sparse(bwperim(imbw));
        
end
end

function cate = get_Categorie(pixel)
if all(pixel==[0,0,0])        % body Categories_1
    cate = 0;
else
    cate = 1;
end
end
