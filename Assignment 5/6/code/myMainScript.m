%% MyMainScript

%Both kernel performs a high pass filtering as they represent the
%derivative in 2D. Kernel K1 performs high pass filtering only along x and
%y directions whereas Kernel K2 performs high pass filtering along
%diagonals as well in addition to the x-y directions. Due to this reason, 
%we can observe in the imshow plots that the contours of DFT are squarish
%for Kernek K1 and Circular for Kernel K2. For observing this more clearly,
%the imagesc plots are also provided. Also, we can see from the surf plots
%that the attenuation of low frequencies is direction specific whereas for
%KErnel K2, it is more or less symmetric along all directions.

tic;
%% Your code here

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];

k1=[0 1 0; 1 -4 1; 0 1 0];
k2=[-1 -1 -1; -1 8 -1; -1 -1 -1];

N=201;
f1=fftshift(fft2(k1,201,201));
f2=fftshift(fft2(k2,201,201));

figure();
imshow(log(1+abs(f1))), title('Kernel K1'), colormap jet, daspect ([1 1 1]), colorbar;

figure();
imshow(log(1+abs(f2))), title('Kernel K2'), colormap jet, daspect ([1 1 1]), colorbar;

figure();
surf(log(1+abs(f1))), title('Kernel K1');
figure();
surf(log(1+abs(f2))), title('Kernel K2');

figure();
imagesc(log(1+abs(f1))), title('Kernel K1'), colormap jet, daspect ([1 1 1]), colorbar;
figure();
imagesc(log(1+abs(f2))), title('Kernel K2'), colormap jet, daspect ([1 1 1]), colorbar;

toc;
