function ret = featureVectorImg(image)


% calculate color moment and local binary pattern of target image
cm = colorMoment(image);
localBinaryPattern = localBP(image, 3);

localBinaryPattern = localBinaryPattern(:);
localBinaryPattern = localBinaryPattern'; %Transpose and vectorize

% Return the vector
ret = [cm localBinaryPattern];
end

function cm = colorMoment(image)

% Compute colour moment of target image based on Stricker Orengo algorithm

image = rgb2hsv(image);

H = double(image(:, :, 1));
H = H(:);
S = double(image(:, :, 2));
S = S(:);
V = double(image(:, :, 3));
V = V(:); 

% Calculate mean, standard deviation and skew of each channel
meanH = mean(H);
sdH = std(H);
skewH = skewness(H);

meanS = mean(S);
sdS = std(S);
skewS = skewness(S);

meanV = mean(V);
sdV = std(V);
skewV = skewness(V);

cm = zeros(1, 9);
cm(1, :) = [meanH, sdH, skewH, meanS, sdS, skewS, meanV, sdV, skewV];

end

function res = localBP(image, radius)

%Calculate local binary pattern of the input image with given number of
%sampling points and predtermined radius. Create Histogram

% Check if the input image is RGB and convert to grayscale
if size(image, 3) == 3
    image = rgb2gray(image);
end;
label = 2*radius + 1; %Radius chosen is 3. Calculate label size
C = round(label/2);

image = uint8(image);
rowMax = size(image,1)-label+1;
colMax = size(image,2)-label+1;
buf = zeros(rowMax, colMax);

for i = 1:rowMax
    for j = 1:colMax
        val = image(i:i+label-1, j:j+label-1);
        val = val+1-val(C,C);
        val(val>0) = 1;
        buf(i,j) = val(C,label) + val(label,label)*2 + val(label,C)*4 + val(label,1)*8 + val(C,1)*16 + val(1,1)*32 + val(1,C)*64 + val(1,label)*128;
    end;
end;

res = hist(buf(:), 255);
end