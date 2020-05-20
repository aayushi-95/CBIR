close all
clear
clc

dbimg = 'image.new'; %Database/Folder of images~1000; 100 samples each

% Find Feature Vector of each image
list_of_imgs = dir(dbimg);
for i=1:size(list_of_imgs,1)
    n = list_of_imgs(i).name;
    imagename = [dbimg '/' n];
    if (n(1) ~= '.')
        findImgfv = imread(imagename);
        fvect(i, :) = featureVectorImg(findImgfv);
        disp(['Feature vector extracted for image: ' imagename]);
    end
end

save('fvect.mat','fvect');

