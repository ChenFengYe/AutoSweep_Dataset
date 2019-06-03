path ='D:\Desktop\test\final_mask';
imgpath ='D:\Desktop\testForModeling';
masklist = dir(path);
imglist = dir(imgpath);
done = [];

for i = 3:length(masklist)
    i
    name = masklist(i).name;
    name = name(1:strfind(name,'.')-1);
    currimg = fullfile(path, masklist(i).name);
    img = imread(currimg);
    marker = strfind(name,'_');
    cr = str2num(name(marker(1)+1:marker(2)-1));
    cg = str2num(name(marker(2)+1:marker(3)-1));
    cb = str2num(name(marker(3)+1:marker(4)-1));
    
    for r = 1:size(img,1)
        for w = 1:size(img,2)
            if img(r,w,1) ~= 0 || img(r,w,2)~=0 || img(r,w,3)~=0
                img(r,w,1) = cr;
                img(r,w,2) = cg;
                img(r,w,3) = cb;
            end
        end
    end
    imwrite(img,[path '\' masklist(i).name]); 
end

for i = 3:length(masklist)
    masklist(i).visited = 0;
    name = masklist(i).name;
    marker = strfind(name,'_');
    masklist(i).oriname = name(1:marker(1)-1);
end


for i = 3:length(masklist)
    i
    if(masklist(i).visited ~= 1)
        imgPath = fullfile(path, masklist(i).name);
        img = imread(imgPath);

        for j = 3:length(masklist)
            if(masklist(j).visited~=1 && i~=j)
                if(strcmp(masklist(i).oriname,masklist(j).oriname))
                    masklist(j).visited = 1;
                    imgPath2 = fullfile(path, masklist(j).name);
                    img2 = imread(imgPath2);
                    for r = 1:size(img2,1)
                        for w = 1:size(img2,2)
                            if img2(r,w,1) ~= 0 || img2(r,w,2)~=0 || img2(r,w,3)~=0
                                img(r,w,:) = img2(r,w,:);
                            end
                        end
                    end
                end
            end
        end
        masklist(i).visited = 1;
        imwrite(img,[path '\' masklist(i).oriname '_mask.png']);
    end
end







%         imwrite(img,['D:\Desktop\result_merge\rename\' name '_mask.png']);
%
%         for j = 3:length(imglist)
%             name2 = imglist(j).name;
%             name2 = name2(1:strfind(name2,'.')-1);
%             if(strcmp(name,name2))
%                 currimg2 = fullfile(imgpath, imglist(j).name);
%                 img2 = imread(currimg2);
%                 imwrite(img2,['D:\Desktop\result_merge\rename\' name '.jpg']);
%                 break;
%             end
%         end
% end

% for i = 3:length(imglist)
%     i
%     if(imglist(i).visited ~= 1)
%         imgPath = fullfile(path, imglist(i).name);
%         img = imread(imgPath);
%
%         for j = 3:length(imglist)
%             if(imglist(j).visited~=1 && i~=j)
%                 if(strcmp(imglist(i).oriname,imglist(j).oriname))
%                     imglist(j).visited = 1;
%                     imgPath2 = fullfile(path, imglist(j).name);
%                     img2 = imread(imgPath2);
%                     for r = 1:size(img2,1)
%                         for w = 1:size(img2,2)
%                             if img2(r,w,1) ~= 0 && img2(r,w,2)~=0 && img2(r,w,3)~=0
%                                 img(r,w,:) = img2(r,w,:);
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%         imglist(i).visited = 1;
%         imwrite(img,['D:\Desktop\result_merge\merge\' imglist(i).oriname '.png']);
%     end
% end


%     cr = str2num(name(marker(2)+1:marker(3)-1));
%     cg = str2num(name(marker(3)+1:marker(4)-1));
%     cb = str2num(name(marker(4)+1:marker(5)-1));
%
%      for r = 1:size(img,1)
%         for w = 1:size(img,2)
%             if img(r,w,1) ~= 0 && img(r,w,2)~=0 && img(r,w,3)~=0
%                 img(r,w,1) = cr;
%                 img(r,w,2) = cg;
%                 img(r,w,3) = cb;
%             end
%         end
%      end
%
%     imwrite(img,[path '\' imglist(i).name]);
