inst_dir = dir('D:\Desktop\ObjectSnapData\Cube_Cylinder_11658\inst\*.mat');
num_cy = 0;
num_cu = 0;
for i=1:length(inst_dir)
    i
    inst_path = [inst_dir(i).folder '\' inst_dir(i).name];
    
    load(inst_path)
    cate = GTinst.Categories;
    num_cu = num_cu +length(find(cate==1));
    num_cy = num_cy + length(find(cate==3))+ length(find(cate==5));
end
num_cu
num_cy 
