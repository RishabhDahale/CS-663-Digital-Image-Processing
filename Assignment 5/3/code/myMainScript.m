%% MyMainScript

tic;
%% Your code here
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

img = load('../data/image_low_frequency_noise.mat').Z;
f=figure();
imagesc (img), title("Original Image"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Original Image.png'));

resultImg = notchFilter(img);
f=figure();
imagesc (resultImg), title("Filtered Image"); colormap(myColorScale), daspect([1 1 1]), colorbar, truesize;
saveas(f, strcat('../images/', 'Filtered Image.png'));

toc;
