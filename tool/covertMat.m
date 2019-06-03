mat_path = 'D:\Desktop\multiple_xiaodata\inst\*.mat';

matDir = dir(mat_path);

for i = 2:length(matDir)
   i
   matPath = fullfile(matDir(i).folder, matDir(i).name);
   load(matPath);
   if size(GTinst.Categories,2)>1 || size(GTinst.Boundaries,2)>1
       GTinst.Categories = reshape(GTinst.Categories,[],1);
       GTinst.Boundaries = reshape(GTinst.Boundaries,[],1);       
       save(matPath,'GTinst');
   end
end