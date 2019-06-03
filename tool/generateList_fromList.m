old_txt_path = 'D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\ImageSets\txt\*.txt';
new_txt_path = 'D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\ImageSets\';
txtDir = dir(old_txt_path);
label_id = 0;

for i = 1:length(txtDir)
    txt_old = importdata([txtDir(i).folder '/' txtDir(i).name]);
    fid_new = fopen([new_txt_path txtDir(i).name(1:end-4) 'train.txt'],'w');
    for j = 1:length(txt_old)
        label_id = label_id + 1;
        fprintf(fid_new, '%s\n', txt_old{j});
    end
    fclose(fid_new);
end