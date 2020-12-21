%% Without Noise
clear;
clc;
I = zeros(300);
J = zeros(300);
I(50:100,50:120) = 255;
J(20:70,120:190) = 255;

FI = fftshift(fft2(I,512,512));
FJ = fftshift(fft2(J,512,512));

FK = (conj(FI).*FJ)./(abs(FI.*FJ));
lgFK = log(abs(FK)+1); figure(); imshow(lgFK); colormap('jet');title("Cross power spectrum"); colorbar;
K = ifft2((ifftshift(FK)));
figure; imshow(K/max(K(:)));title("Inverse Fourier Transform");
impixelinfo;

%% With Noise

In = I + random('norm',0,20,300,300);
Jn = J + random('norm',0,20,300,300);

FIn = fftshift(fft2(In,512,512));
FJn = fftshift(fft2(Jn,512,512));

FKn = (conj(FIn).*FJn)./(abs(FIn.*FJn));
lgFKn = log(abs(FKn)+1); figure(); imshow(lgFKn); colormap('jet'); title("Cross power spectrum with noise");colorbar;
Kn = ifft2((ifftshift(FKn)));
figure; imshow(Kn/max(Kn(:)));title("Inverse Fourier transform - with noise");
impixelinfo;
