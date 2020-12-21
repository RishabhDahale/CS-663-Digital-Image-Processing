%% MyMainScript

tic;
%% Your code here
%% 1.a Solution
% For image to be viewed properly, sampling plays an important role. If the
% sampling rate is not high enough to capture all the details of the image,
% it creats aliasing. This results in strange atrifacts in the image that
% were are not really present.
% For the image in the example below this effect can be clearly seen. $d=1$
% is the original image. There are no additional circle centers because the
% sampling rate of the image is good enough to capture all the imformation 
% correctly. When we subsample it to reduce the image dimension using 
% $d=2$, we can see additional 8 circle centers. This is because we have
% halved our sampling rate which resulted in higher frequencies getting
% indistinguishable with some of the lower frequencies. When we further
% reduce the dimension ($d=3$), we get an image with with 8 bright circle
% center and 16 faint ones. This is because we have reduced the sampling
% rate to a third of the original value because of the we can see an even
% higher distorting of the higher frequencies.
% To counter this, before downsampling the image, we should first pass it
% through a low pass filter ensuring that the cutoff frequency of the
% filter is below half of the new sampling rate. This will ensure that the
% higher frequencies get supressed before downsampling, and will not
% interfere with the final image creating distortions.
% NOTE: While using the publish feature of Matlab, image resizing was
% happening, which led to some moire effect. To remove this we had to
% separately save the images and then replace them in the report.
myShrinkImageByFactorD();           % 1.a

%% 1.b Solution
% Bilinear interpolation is a simple method of interpolation which assumes
% that the intensity value at any point inside a grid is a linear
% combination of the intensities at the 4 ends. This provides a simple
% method for predicting the value at any point inside the grid which can be
% used for upsampling the image.
% Although this provides a smooth method of upsampling, this is not the
% idea way to do it.
biLinearInt = myBilinearInterpolation();          % 1.b

%% 1.c Solution
% Nearest neighbout interpolation is one of the simplest method of
% interpolation. In this method we replicate the value of the nearest pixel
% for upsampling the image. Because of this, when we upsample the image, we
% see small box like entities in image.
nearestNeighInt = myNearestNeighborInterpolation();   % 1.c

%% 1.d Solution
% Bicubic interpolation is a sophisticated method of interpolation which
% takes into account the smoothness over the adjecent grids. Advantage
% which this method provides over bilinear interpolation is that it matches
% the first derivative over adjecent region making the overall region
% smooth.
biCubicInt = myBicubicInterpolation();           % 1.d

%% 1.e Solution
% Here we compare the results from 3 different methods of interpolation.
% 1. Bilinear Interpolation
% 2. Nearest Neighbour Interpolation
% 3. Bicubic Interpolation
% For this comparison, We have used a $50 \times 50$ window. It can be
% easily observed that the image with interpolation as nearest neighbour,
% shows huge blocks of pixels and sudden changes of intensities. Comparing
% this to bilinear case, we can see that bilinear interpolation provides
% better transition from one shade to another. In the case of bicubic
% interpolation, this effect can be seen much more clearly. Some of the
% area where the difference can be very clearly seen are the left side blue
% rows in all the 3 images. For the nearest neighbour approach, it can be
% clearly seen that there is slight gradient, but the smoothness of the
% change is not that good. For the bilinear case it can be seen that there
% is some variation in the blue shade. This may be because of noise. But
% for the bicubic interpolation it can be very clearly seen that the
% overall the image have smothned and the gradient along the x direction of
% the image have also improved. Overall if we compare the bilinear and
% bicibic results, we can see that for bilinear one, there are some sudden
% changes in the intensities, whereas for cubic that have been smothened
% out.
size = 50; startI = 200; startJ = 75;
cropLinear = biLinearInt(startI:startI+size, startJ:startJ+size);
cropNeighrestNeigh = nearestNeighInt(startI:startI+size, startJ:startJ+size);
cropBiCubic = biCubicInt(startI:startI+size, startJ:startJ+size);

figure();
imagesc(single(cropLinear)), title('Bilinear Interpolation'), ...
    daspect ([1 1 1]), colormap('jet'), colorbar;
figure();
imagesc(single(cropNeighrestNeigh)), title('Nearest Neighbour'), ...
    daspect ([1 1 1]), colormap('jet'), colorbar;
figure();
imagesc(single(cropBiCubic)), title('Bicubic Interpolation'), ...
    daspect ([1 1 1]), colormap('jet'), colorbar;

%% 1.f Solution
% For rotating an image by $30^\circ$ clockwise, it is the same as rotating
% the underlying grig by $30^\circ$ counterclockwise. To get the the
% resultant image, simple bilinear interpolation was used.
myImageRotation();
toc;
