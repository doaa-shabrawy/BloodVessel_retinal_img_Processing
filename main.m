TestImg = imread('Test Images/2_right.jpeg');
ResizedImg = imresize(TestImg,[584 565]);%% عشان نغير من حجم الصور
ConvertedImg = im2double(ResizedImg);%% هيحول البكسل لقيم عشريه عشان هيقسم لاجزاء صغيره 
LabImg = rgb2lab(ConvertedImg);%cie lab colors هتحول الصورة من rgb ل
fill = cat(3,1,0,0);
FilledImg = bsxfun(@times, fill, LabImg);
ReshapedLImg = reshape(FilledImg , [],3);%3 هو البعد الحالي 
[cof,score]= pca(ReshapedLImg);
score = reshape(score , size(LabImg));
score = score(: ,: ,1);
GrayImg = (score-min(score(:)))./(max(score(:))-min(score(:)));% احول الصورة لتدرج رمادي
EnhancedImg = adapthisteq(GrayImg, 'numTiles',[8 8],'nBins',128);

AvgFilter = fspecial('average',[9 9]);% فلتر 
FilteredImg = imfilter(EnhancedImg,AvgFilter);

% figure ,imshow(FilteredImg),title("Filtered Image");

SubstructedImg = imsubtract(FilteredImg,EnhancedImg);

level = thresholdLevel(SubstructedImg);
BinaryImg = im2bw(SubstructedImg,level-0.008);

% figure,imshow(BinaryImg),title('Binar Image');

CleanImg = bwareaopen(BinaryImg,100);
% figure,imshow(CleanImg),title('Cleaned Image');

ComplementedImg = imcomplement(CleanImg);
% figure,imshow(ComplementedImg),title('Complemented Image');

Final_resultImg = colorizeImage(ResizedImg,ComplementedImg,[0 0 0]);

% figure,imshow(Final_resultImg),title('Final Image');



figure
subplot(231),imshow(TestImg),title("Test Image");
subplot(232),imshow(FilteredImg),title("Filtered Image");
subplot(233),imshow(BinaryImg),title('Binar Image');
subplot(234),imshow(CleanImg),title('Cleaned Image');
subplot(235),imshow(ComplementedImg),title('Complemented Image');
subplot(236),imshow(Final_resultImg),title('Final Image');


