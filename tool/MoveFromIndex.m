txt_path = 'D:\Desktop\ObjectSnapData\Sub_Geonet_data\Sub_Geonet_ob_data_6class\ImageSets\val_6_4.txt';
det_path = 'D:\Desktop\ObjectSnapData\Sub_Geonet_data\Sub_Geonet_ob_data_6class\'
source_path = 'D:\Desktop\ObjectSnapData\Sub_Geonet_data\Sub_Geonet_ob_data_6class\'
txtdir = importdata(txt_path);
errorList = {};

parfor i = 1:length(txtdir)
    i
    %movefile([source_path txtdir{i} '.jpg'], [det_path txtdir{i} '.jpg'])
    if(exist([source_path 'img2\' txtdir{i} '.jpg'], 'file'))
        movefile([source_path 'img2\' txtdir{i} '.jpg'], [det_path 'img\' txtdir{i} '.jpg'])
%         copyfile([source_path 'gray\' txtdir{i} '.png'], [det_path 'gray\' txtdir{i} '.png'])
%         copyfile([source_path 'line\' txtdir{i} '.png'], [det_path 'line\' txtdir{i} '.png'])
%         copyfile([source_path 'seg\' txtdir{i} '.png'], [det_path 'seg\' txtdir{i} '.png'])
    else
%         errorList{length(errorList)+1} = [source_path txtdir{i} '.jpg'];
    end    
end