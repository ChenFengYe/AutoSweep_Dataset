txt_path = 'D:\Desktop\ExperimentData\Exper_MeanAP\11_15_RCNN_7_11_epoch_pkl\*.txt'
inst_prefix = 'D:\Desktop\ExperimentData\Exper_MeanAP\11_15_RCNN_7_11_epoch_pkl\';
img_prefix = 'D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\';
rlt_prefix = 'D:\Desktop\ExperimentData\Exper_MeanAP\11_15_RCNN_7_11_epoch_pkl_subTest\';
txt_dir = dir(txt_path);
parfor i =1:length(txt_dir)
    txts = importdata([txt_dir(i).folder '\' txt_dir(i).name]);
    clses_num = zeros(4,1);
    img_name = txt_dir(i).name(1:end-4);
    if isempty(txts) 
        continue;
    end
    for j = 1:length(txts.textdata)
        disp([i j])
        inst_cls = txts.data(j,1);
        clses_num(inst_cls) = clses_num(inst_cls) +1;
        inst_name = txts.textdata{j};
        inst_path = [inst_prefix inst_name];
        line_path = [img_prefix 'line\' img_name '.png'];
        gray_path = [img_prefix 'gray\' img_name '.png'];
        
        img_g_inst = imread(inst_path);
        img_r_line = imread(line_path);
        img_b_gray = imread(gray_path);
        
        img_result = MergeWithLineAndGray(img_g_inst, img_r_line, img_b_gray, inst_cls, clses_num(inst_cls));
        imwrite(img_result,[rlt_prefix inst_name(1:end-4) '.jpg'])
    end
end
    
function img_result = MergeWithLineAndGray(img_g_inst, img_r_line, img_b_gray, cls, cls_num)
img_result = uint8([]);
img_result(:,:,1) = img_r_line;
img_g_inst = getNewColor(cls)/200.*img_g_inst;
img_result(:,:,2) = img_g_inst;
img_result(:,:,3) = img_b_gray;
end
function color = getNewColor(label)
if label==1   % cubo
    color = 50;
elseif label==2   % cufa
    color = 100;
elseif label==3   % cybo
    color = 150;
elseif label==4   % cyfa
    color = 200;
elseif label==5   % grip
    color = 250;
end
end
% function color get_instance_color(class_name, i_instance):
%     if class_name == '1':
%         color = (i_instance*10, 0, 255)
%     elif class_name == '2':
%         color = (i_instance*10, i_instance*10, 255)
%     elif class_name == '3':
%         color = (i_instance*10, 0, 200)
%     elif class_name == '4':
%         color = (i_instance*10, i_instance*10, 200)
%     elif class_name == '5':
%         color = (i_instance * 10, 0, 150)
% return color