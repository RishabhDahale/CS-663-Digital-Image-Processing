%% MyMainScript

tic;
%% Your code here
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

img = imread('../data/barbara256.png');
f=figure();
imagesc (img), title("Original Image"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Original Image.png'));

param = 40;

filtType = "ideal";
resultImg = lowPassFilter(img, filtType, param);
f=figure();
imagesc (resultImg), title("Ideal Filtered Image - D = 40"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Ideal Filtered Image with D = 40.png'));

filtType = "gaussian";
resultImg = lowPassFilter(img, filtType, param);
f=figure();
imagesc (resultImg), title("Gaussian Filtered Image - D = 40"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Gaussian Filtered Image with D = 40.png'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param = 80;

filtType = "ideal";
resultImg = lowPassFilter(img, filtType, param);
f=figure();
imagesc (resultImg), title("Ideal Filtered Image - D = 80"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Ideal Filtered Image with D = 80.png'));

filtType = "gaussian";
resultImg = lowPassFilter(img, filtType, param);
f=figure();
imagesc (resultImg), title("Gaussian Filtered Image - D = 80"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Gaussian Filtered Image with D = 80.png'));

toc;
