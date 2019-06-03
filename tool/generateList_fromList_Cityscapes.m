old_txt_path = 'D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\ImageSets\txt\*.txt';
new_txt_path = 'D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\ImageSets\';
txtDir = dir(old_txt_path);
label_id = 0;

for i = 1:length(txtDir)
    txt_old = importdata([txtDir(i).folder '/' txtDir(i).name]);
    fid_new = fopen([new_txt_path txtDir(i).name(1:end-4) 'MaskRCNN.txt'],'w');
    for j = 1:length(txt_old)
        label_id = label_id + 1;
        fprintf(fid_new, '%d\t%s\t%s\n', label_id, ['img/' txt_old{j} '.jpg'], ['instanceIds/' txt_old{j} '.png']);
    end
    fclose(fid_new);
end