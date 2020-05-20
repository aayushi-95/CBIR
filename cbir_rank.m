close all
clear
clc

dbimg = 'image.new';
% Query Image
imgName = '320.jpg';

numSim = 5; %Find n number of closest similar images 

I = [dbimg '/' imgName];
Qimg = imread(I);

% Query Image: Extract Features 
feature_query = featureVectorImg(Qimg);
disp(['Feature Extraction of Query Image done']);
load('fvect.mat');

list_img = dir(dbimg);
for i=1:size(list_img,1)
    n = list_img(i).name;
    imgname = [dbimg '/' n];
    if (n(1) ~= '.')
        ed(i,:) = euclidian_dist(feature_query, fvect(i,:));
    end
end

m = max(ed);
mod_ed = zeros(size(ed,1), 1);
for i=1:size(ed,1)
    if (ed(i)==0)
        mod_ed(i) = 2*m;
    else
        mod_ed(i) = ed(i);
    end
end

figure, 
imshow(imread(I));
title('Query Image');

for i=1:numSim
    %Based on distance calculation find closest object
    idx = find(mod_ed == min(mod_ed));

    figure,
    imshow(imread([dbimg '/' list_img(idx).name]))
    title(['Found similar image :' num2str(i)]);
    
    mod_ed(idx) = m;
end

% clear filename idx imagepath imgname imgpath m

function dist = euclidian_dist(x1, x2)
sub = x1-x2;
dist = sqrt(sub * sub');
end