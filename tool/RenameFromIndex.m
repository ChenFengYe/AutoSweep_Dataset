txt_path = 'D:\Desktop\SubGeonetData\ImageSets\Main\val.txt';
img_path = 'D:\Desktop\SubGeonetData\Segmentation\*.png'
img_dir = dir(img_path);

txtdir = importdata(txt_path);
for i = 1:length(txtdir)
    movefile([img_dir(i).folder '\' img_dir(i).name],[img_dir(i).folder '\' txtdir{str2num(img_dir(i).name(1:end-11))+1} '_result_line' '.png']);
end