function [resultImg] = notchFilter(img)
    [M, N] = size(img);
    extendedImg = zeros(2*M, 2*N);
    filter = ones(2*M, 2*N);
    extendedImg((M/2)+1:3*M/2, (N/2)+1:3*N/2) = img;
    
    fim = fftshift(fft2(extendedImg));
    absfim = log(abs(fim)+1);
    f=figure();
    imshow(absfim,[-1 18]); title("Log Magnitude FT"); colormap (jet); colorbar;
    saveas(f, strcat('../images/', 'Log Magnitude FT.png'));
    
    filter(232:240, 243:251) = 0;
    filter(274:282, 264:272) = 0;
    
    absfim = absfim.*filter;
    f=figure();
    imshow(absfim,[-1 18]); title("Log Magnitude FT after applying filter"); colormap (jet); colorbar;
    saveas(f, strcat('../images/', 'Filtered Log Magnitude FT.png'));
    
    resultImg = fim.*filter;
    resultImg = real(ifft2(ifftshift(resultImg)));
    resultImg = resultImg((M/2)+1:3*M/2, (N/2)+1:3*N/2);
end