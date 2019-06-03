txt_path = 'D:\Desktop\valMaskRCNN.txt';
source_path = 'D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\'
det_path = 'D:\Desktop\'
txtdir = importdata(txt_path);
errorList = {};

for i = 1:length(txtdir)
    i
    %movefile([source_path txtdir{i} '.jpg'], [det_path txtdir{i} '.jpg'])
    fileName = split(txtdir{i},'	');
    fileName = split(fileName(2).split,'/');
    fileName = split(fileName(2).split,'.');
    fileName = fileName{1};
    if(exist([source_path 'instanceIds_5classes\' fileName '.png'], 'file'))
%         copyfile([source_path 'img\' txtdir{i} '.jpg'], [det_path 'img\' txtdir{i} '.jpg'])
%         copyfile([source_path 'gray\' txtdir{i} '.png'], [det_path 'gray\' txtdir{i} '.png'])
%         copyfile([source_path 'line\' txtdir{i} '.png'], [det_path 'line\' txtdir{i} '.png'])
%         copyfile([source_path 'seg\' txtdir{i} '.png'], [det_path 'seg\' txtdir{i} '.png'])
          copyfile([source_path 'instanceIds_5classes\' fileName '.png'], [det_path 'instanceIds_val\' fileName '.png'])
    else
        errorList{length(errorList)+1} = [source_path txtdir{i} '.jpg'];
    end    
end