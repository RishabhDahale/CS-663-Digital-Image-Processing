function [resultImg] = lowPassFilter(img, filtType, param)
    [H, W] = size(img);
    filter = zeros(2*H, 2*W);
    if filtType=="ideal"
        filt = fspecial('disk', param);
        [h, w] = size(filt);
        filter(H-((h-1)/2):H+((h-1)/2),W-((w-1)/2):W+((w-1)/2)) = filt;
    else
        filter = fspecial('gaussian',[2*H, 2*W],param);
    end
    filtFT = fftshift(fft2(filter));
    absfiltFT = log(abs(filtFT)+1);
    f=figure();
    imshow(absfiltFT,[0 1]); title([filtType 'Filter Log Magnitude FT with D=' num2str(param)]); colormap (jet); colorbar;
    saveas(f, strcat('../images/', filtType, ' Filter Log Magnitude FT with D=', num2str(param), '.png'));
    
    if filtType=="ideal"
        filter(filter>0) = 1;
    end
    
    [M, N] = size(img);
    extendedImg = zeros(2*M, 2*N);
    extendedImg((M/2)+1:3*M/2, (N/2)+1:3*N/2) = img;
    
    imgFT = fftshift(fft2(extendedImg));
    resultImg = imgFT.*filter;
    resultImg = real(ifft2(ifftshift(resultImg)));
    resultImg = resultImg((H/2)+1:3*H/2, (W/2)+1:3*W/2);
end